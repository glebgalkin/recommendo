import {APIGatewayProxyEvent} from "aws-lambda";
import {FERecommendation} from "../types/fe-recommendation";

export const validateRecommendation = (event: APIGatewayProxyEvent) => {
    const recommendation: FERecommendation = JSON.parse(event.body!)
    if(!recommendation.title){
        throw new Error('No recommendation title provided')
    }

    else if(!recommendation.cityId){
        throw new Error('No city id provided')
    }

    else if(!recommendation.source || recommendation.source.length === 0){
        throw new Error('No source provided')
    }

    else if(!recommendation.source[0].id){
        throw new Error('No source id provided')
    }

    else if(!recommendation.source[0].type){
        throw new Error('No source type provided')
    }

    return recommendation
}