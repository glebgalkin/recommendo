import {APIGatewayProxyEvent} from "aws-lambda";
import {MongoClient} from "mongodb";
import {FERecommendation, Recommendation} from "../types/recommendation";
import {validateRecommendation} from "./recommendation-validator";
import {parseUserMeta} from "./user-meta-parser";
import {UserMeta} from "../types/user-meta";
import {mapRecommendation} from "../mapper/recommendation-mapper";
import {upsertRecommendation} from "../repository/recommendation-repository";
import {getGooglePlaceInfo} from "./address-parser";
import {GoggleApiPlaceInfo} from "../types/google-map-api";

export const processInput = async (event: APIGatewayProxyEvent, client: MongoClient) => {
    console.log(event)
    const db = await client.db(process.env.MONGODB_NAME);

    const userMeta: UserMeta = parseUserMeta(event)
    const feRecommendation: FERecommendation = validateRecommendation(event)
    const googlePlaceInfo: GoggleApiPlaceInfo|null = await getGooglePlaceInfo(feRecommendation)
    const recommendation: Recommendation = mapRecommendation(userMeta, feRecommendation, googlePlaceInfo)
    return await upsertRecommendation(recommendation, db)
}