import {APIGatewayProxyEvent} from "aws-lambda";
import {parseUserRecommendationRequest} from "./service/recommendation-validator";
import {triggerLambda} from "@reco-cache/cache/utils/lambda-trigger";
import {RECOMMENDATION_PROCESSOR} from "@reco-cache/cache/constants/lambda-names";
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";
import {SUCCESSFUL_RESPONSE} from "@reco-cache/cache/constants/responses";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose"
import {saveUserRecommendation} from "@reco-cache/cache/service/recommendo-service";
import {LambdaTriggerType} from "@reco-cache/cache/types/lambda-trigger-type";

export const handler = async (event: APIGatewayProxyEvent) => {
    try {
        await connectDB(process.env.MONGODB_CONNECTION_STRING!);

        const userRecommendationModel = parseUserRecommendationRequest(event);

        await saveUserRecommendation(userRecommendationModel);

        await triggerLambda(RECOMMENDATION_PROCESSOR, LambdaTriggerType.Event, userRecommendationModel);

        return sendSuccessfulResponse(SUCCESSFUL_RESPONSE);

    } catch (exception) {
        return sendErrorResponse(exception);
    }
}
