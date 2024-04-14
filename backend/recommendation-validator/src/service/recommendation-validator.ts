import {FERecommendation} from "../types/recommendation";
import {APIGatewayProxyEvent} from "aws-lambda";

export const validateRecommendation = (event: APIGatewayProxyEvent) => {
    const recommendation: FERecommendation = JSON.parse(event.body!)
    if(!recommendation.title){
        throw new Error('No recommendation title provided')
    }

    else if(!recommendation.socials.instagram){
        throw new Error('No instagram url provided')
    }

    else if(!recommendation.city.name){
        throw new Error('No city name is provided')
    }

    else if(!recommendation.city.id){
        throw new Error('No city id is provided')
    }

    return recommendation
}