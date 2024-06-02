import {APIGatewayProxyEvent} from "aws-lambda";
import {validateRecommendation} from "./service/recommendation-validator";
import {parseUserMeta} from "./service/user-parser";
import {buildBeRecommendationDto} from "./service/recommendation-mapper";
import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";
import {SUCCESSFUL_ALREADY_CREATED, SUCCESSFUL_RESPONSE} from "./constants/responses";
import {triggerLambda} from "@reco-cache/cache/utils/lambda-trigger";
import {LambdaTriggerType} from "@reco-cache/cache/types/lambda-trigger-type";
import {RECOMMENDATION_PROCESSOR} from "@reco-cache/cache/constants/lambda-names";
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";
import {findBySocial} from "@reco-cache/cache/model/repository/recommendo-entity";
import {UserRecommendation} from "@reco-cache/cache/model/repository/user-recommendation";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose"


export const lambdaHandler = async (event: APIGatewayProxyEvent) => {
    try {
        await connectDB(process.env.MONGODB_CONNECTION_STRING!);

        const feRecommendation = validateRecommendation(event);
        const userMeta = parseUserMeta(event);

        const re = await findBySocial(feRecommendation.source.type, feRecommendation.source.id);
        if (re) {
            const ur = await UserRecommendation.findOne({userId: userMeta.userId, recommendoEntity: re.id}).exec();
            if (ur) {
                return sendSuccessfulResponse(SUCCESSFUL_ALREADY_CREATED);
            } else {
                const newUr = new UserRecommendation(
                    {
                        cityId: feRecommendation.cityId,
                        text: feRecommendation.text,
                        userId: userMeta.userId,
                        recommendoEntity: re.id,
                    }
                );
                await newUr.save();
            }
        }


        const recommendationDto: BERecommendation = buildBeRecommendationDto(feRecommendation, userMeta, re?.id);
        await triggerLambda(RECOMMENDATION_PROCESSOR, LambdaTriggerType.Event, recommendationDto);
        return sendSuccessfulResponse(SUCCESSFUL_RESPONSE);
    } catch (exception) {
        return sendErrorResponse(exception);
    }
}
