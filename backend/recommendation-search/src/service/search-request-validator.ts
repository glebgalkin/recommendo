import {APIGatewayProxyEvent} from "aws-lambda";
import {SearchRequest} from "../types/search-request";

export const validateSearchRequest = (event: APIGatewayProxyEvent): SearchRequest => {
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