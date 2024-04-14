import {APIGatewayProxyEvent} from "aws-lambda";
import {MongoClient} from "mongodb";
import {FERecommendation, Recommendation} from "../types/recommendation";
import {validateRecommendation} from "./recommendation-validator";
import {parseUserMeta} from "./user-meta-parser";
import {UserMeta} from "../types/user-meta";
import {mapRecommendation} from "./recommendation-mapper";
import {saveRecommendation} from "../repository/recommendation-repository";

export const processInput = async (event: APIGatewayProxyEvent, client: MongoClient) => {
    console.log(event)

    const userMeta: UserMeta = parseUserMeta(event)
    const feRecommendation: FERecommendation = validateRecommendation(event)
    const recommendation: Recommendation = mapRecommendation(userMeta, feRecommendation)
    return await saveRecommendation(recommendation, client)
}