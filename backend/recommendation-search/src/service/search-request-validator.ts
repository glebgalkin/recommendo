import {APIGatewayProxyEvent} from "aws-lambda";
import {SearchModel} from "@reco-cache/cache/model/service/search-model";

export const parseSearchRequest = (event: APIGatewayProxyEvent): SearchModel => {
    const cityId = event.queryStringParameters?.cityId;
    if (!cityId) {
        throw new Error('No city id provided')
    }
    const offset = parseInt(event.queryStringParameters?.offset || '0');
    const limit = parseInt(event.queryStringParameters?.limit || '10');
    const term = event.queryStringParameters?.term;

    return {
        cityId: cityId,
        offset: offset,
        limit: limit,
        term: term,
    };
}