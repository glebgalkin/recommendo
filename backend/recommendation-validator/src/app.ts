import {APIGatewayProxyEvent} from "aws-lambda";
import {validateRecommendation} from "./service/recommendation-validator";
import {parseUserMeta} from "./service/user-parser";
import {buildBeRecommendationDto} from "./service/recommendation-mapper";
import {FERecommendation} from "./types/fe-recommendation";
import {UserMeta} from "@reco-cache/cache/types/user-meta";
import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";
import {SUCCESSFUL_RESPONSE} from "./constants/responses";
import {triggerLambda} from "@reco-cache/cache/utils/lambda-trigger";
import {LambdaTriggerType} from "@reco-cache/cache/types/lambda-trigger-type";
import {RECOMMENDATION_PROCESSOR} from "@reco-cache/cache/constants/lambda-names";
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";

export const lambdaHandler = async (event: APIGatewayProxyEvent) => {
    try{
        const feRecommendation: FERecommendation = validateRecommendation(event)
        const userMeta: UserMeta = parseUserMeta(event)
        const recommendationDto: BERecommendation = buildBeRecommendationDto(feRecommendation, userMeta)
        const triggerResult = await triggerLambda(RECOMMENDATION_PROCESSOR, LambdaTriggerType.Event, recommendationDto)
        return sendSuccessfulResponse(SUCCESSFUL_RESPONSE)
    } catch (exception){
        return sendErrorResponse(exception)
    }
}
