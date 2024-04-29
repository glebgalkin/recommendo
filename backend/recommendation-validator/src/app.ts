import {APIGatewayProxyEvent} from "aws-lambda";
import {validateRecommendation} from "./service/recommendation-validator";
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses"
import {parseUserMeta} from "./service/user-parser";
import {buildBeRecommendationDto} from "./service/recommendation-mapper";
import {FERecommendation} from "../../reco-cache/dist/types/fe-recommendation";
import {UserMeta} from "../../reco-cache/dist/types/user-meta";
import {BERecommendation} from "../../reco-cache/dist/types/be-recommendation-dto";
import {triggerLambda} from "../../reco-cache/dist/utils/lambda-trigger";
import {RECOMMENDATION_PROCESSOR} from "../../reco-cache/dist/constants/lambda-names";
import {LambdaTriggerType} from "../../reco-cache/dist/types/lambda-trigger-type";
import {SUCCESSFUL_RESPONSE} from "./constants/responses";

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
