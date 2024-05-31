import {APIGatewayProxyEvent} from "aws-lambda";
import {FERecommendation} from "../types/fe-recommendation";

export const validateRecommendation = (event: APIGatewayProxyEvent): FERecommendation => {
    const recommendation: FERecommendation = JSON.parse(event.body!);
    if (!recommendation.text) {
        throw new Error('No recommendation title provided')
    } else if (!recommendation.cityId) {
        throw new Error('No city id provided');
    } else if (!recommendation.source) {
        throw new Error('No source provided');
    } else if (!recommendation.source.id) {
        throw new Error('No source id provided');
    } else if (!recommendation.source.type) {
        throw new Error('No source type provided');
    }

    return recommendation;
}