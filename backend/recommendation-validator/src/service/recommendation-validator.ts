import {APIGatewayProxyEvent} from "aws-lambda";
import {FERecommendation} from "../types/fe-recommendation";

export const validateRecommendation = (event: APIGatewayProxyEvent) => {
    const recommendation: FERecommendation = JSON.parse(event.body!)
    if(!recommendation.title){
        throw new Error('No recommendation title provided')
    }

    else if(!recommendation.city.name){
        throw new Error('No city name is provided')
    }

    else if(!recommendation.city.id){
        throw new Error('No city id is provided')
    }

    else if(!recommendation.source || recommendation.source.length === 0){
        throw new Error('No source provided')
    }

    return recommendation
}