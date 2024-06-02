import {APIGatewayProxyEvent} from "aws-lambda";
import {validateSearchRequest} from "./service/search-request-validator";
import {sendErrorResponse} from "@reco-cache/cache/utils/responses";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose"
import {RecommendoEntity} from "@reco-cache/cache/model/repository/recommendo-entity";

export const handler = async (event: APIGatewayProxyEvent) => {
    try {
        await connectDB(process.env.MONGODB_CONNECTION_STRING!);

        const searchRequest = validateSearchRequest(event);

        console.debug(searchRequest);

        const filter = {
            cityId: searchRequest.cityId,
        } as any;
        if (searchRequest.term) {
            filter.$text = {$search: searchRequest.term};
        }
        const result = await RecommendoEntity.aggregate([
            {$match: filter},
            {
                $lookup: {
                    from: 'user_recommendations',
                    localField: '_id',
                    foreignField: 'recommendoEntity',
                    as: 'count'
                }
            },
            {$addFields: {count: {$size: '$count'}}},
            {$skip: searchRequest.offset},
            {$limit: searchRequest.limit},
        ]);


        return {
            statusCode: 200,
            body: JSON.stringify(result)
        };
    } catch (exception) {
        return sendErrorResponse(exception);
    }
}
