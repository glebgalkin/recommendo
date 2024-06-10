import {APIGatewayProxyEvent} from "aws-lambda";
import {SearchRecommendationsRequest} from "@reco-cache/cache/model/service/user-recommendation-request";

export const parseSearchRequest = (event: APIGatewayProxyEvent): SearchRecommendationsRequest => {
    const cityId = event.queryStringParameters?.cityId;
    if (!cityId) {
        throw new Error('No city id provided')
    }
    const offset = parseInt(event.queryStringParameters?.offset || '0');
    const limit = parseInt(event.queryStringParameters?.limit || '10');
    const locale = event.queryStringParameters?.locale ?? 'en';
    const term = event.queryStringParameters?.term

    return {
        cityId: cityId,
        offset: offset,
        limit: limit,
        term: term,
        locale: locale,
    };
}