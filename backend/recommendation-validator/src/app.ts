import {APIGatewayProxyEvent} from "aws-lambda";
import {validateRecommendation} from "./service/recommendation-validator";
import {FERecommendation} from "@reco-cache/cache/types/fe-recommendation"
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses"
import {parseUserMeta} from "./service/user-parser";
import {UserMeta} from "@reco-cache/cache/types/user-meta"
import {BERecommendationDto} from "@reco-cache/cache/types/be-recommendation-dto"
import {buildBeRecommendationDto} from "./service/recommendation-mapper";
import {triggerLambda} from "@reco-cache/cache/utils/lambda-trigger"
import {RECOMMENDATION_PROCESSOR} from "@reco-cache/cache/constants/lambda-names"
import {LambdaTriggerType} from "@reco-cache/cache/types/lambda-trigger-type"

export const lambdaHandler = async (event: APIGatewayProxyEvent) => {
    try{
        const feRecommendation: FERecommendation = validateRecommendation(event)
        const userMeta: UserMeta = parseUserMeta(event)
        const recommendationDto: BERecommendationDto = buildBeRecommendationDto(feRecommendation, userMeta)
        const triggerResult = await triggerLambda(RECOMMENDATION_PROCESSOR, LambdaTriggerType.Event, recommendationDto)
        return sendSuccessfulResponse("Recommendation accepted")
    } catch (exception){
        return sendErrorResponse(exception)
    }
}