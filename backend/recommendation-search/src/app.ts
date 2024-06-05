import {APIGatewayProxyEvent} from "aws-lambda";
import {parseSearchRequest} from "./service/search-request-validator";
import {sendErrorResponse} from "@reco-cache/cache/utils/responses";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose"
import {searchRecommendoEntities} from "@reco-cache/cache/service/recommendo-service";

export const handler = async (event: APIGatewayProxyEvent) => {
    try {
        await connectDB(process.env.MONGODB_CONNECTION_STRING!);

        const searchModel = parseSearchRequest(event);

        const result = searchRecommendoEntities(searchModel);

        return {
            statusCode: 200,
            body: JSON.stringify(result)
        };
    } catch (exception) {
        return sendErrorResponse(exception);
    }
}
