import {APIGatewayProxyEvent} from "aws-lambda";
import {validateRecommendation} from "./service/recommendation-validator";
import {parseUserMeta} from "./service/user-parser";
import {buildBeRecommendationDto} from "./service/recommendation-mapper";
import {FERecommendation} from "./types/fe-recommendation";
import {UserMeta} from "../../reco-cache/dist/types/user-meta";
import {BERecommendation} from "../../reco-cache/dist/types/be-recommendation";
import {SUCCESSFUL_RESPONSE} from "./constants/responses";
import {triggerLambda} from "../../reco-cache/dist/utils/lambda-trigger";
import {LambdaTriggerType} from "../../reco-cache/dist/types/lambda-trigger-type";
import {RECOMMENDATION_PROCESSOR} from "../../reco-cache/dist/constants/lambda-names";
import {sendErrorResponse, sendSuccessfulResponse} from "../../reco-cache/dist/utils/responses";

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
