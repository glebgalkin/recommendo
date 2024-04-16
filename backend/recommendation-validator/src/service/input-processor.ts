import {APIGatewayProxyEvent} from "aws-lambda";
import {MongoClient} from "mongodb";
import {FERecommendation, Recommendation} from "../types/recommendation";
import {validateRecommendation} from "./recommendation-validator";
import {parseUserMeta} from "./user-meta-parser";
import {UserMeta} from "../types/user-meta";
import {mapRecommendation} from "./recommendation-mapper";
import {upsertRecommendation} from "../repository/recommendation-repository";
import {getAddress} from "./address-parser";

export const processInput = async (event: APIGatewayProxyEvent, client: MongoClient) => {
    console.log(event)
    const db = await client.db(process.env.MONGODB_NAME);

    const userMeta: UserMeta = parseUserMeta(event)
    const feRecommendation: FERecommendation = validateRecommendation(event)
    const address = await getAddress(feRecommendation)
    const recommendation: Recommendation = mapRecommendation(userMeta, feRecommendation, address)
    return await upsertRecommendation(recommendation, db)
}