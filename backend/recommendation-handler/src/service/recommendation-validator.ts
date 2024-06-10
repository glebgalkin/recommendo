import {APIGatewayProxyEvent} from "aws-lambda";
import {UserRecommendationModel} from "@reco-cache/cache/model/service/user-recommendation";

export const parseUserRecommendationRequest = (event: APIGatewayProxyEvent): UserRecommendationModel => {
    const recommendation = JSON.parse(event.body!);
    if (!recommendation.text) {
        throw new Error('No recommendation title provided')
    } else if (!recommendation.cityId) {
        throw new Error('No city id provided');
    } else if (!recommendation.source?.id) {
        throw new Error('No source id provided');
    } else if (!recommendation.source?.type) {
        throw new Error('No source type provided');
    } else if (!event.requestContext?.authorizer?.jwt?.claims?.user_id) {
        throw new Error('No user id provided');
    }

    return {
        text: recommendation.text,
        source: {
            type: recommendation.source.type,
            id: recommendation.source.id,
        },
        cityId: recommendation.cityId,
        userId: event.requestContext.authorizer.jwt.claims.user_id,
    };
}