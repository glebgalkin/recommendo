import {APIGatewayProxyEvent} from "aws-lambda";
import {MongoClient} from "mongodb";
import {validateRecommendation} from "./recommendation-validator";
import {parseUserMeta} from "./user-meta-parser";
import {UserMeta} from "../types/user-meta";
import {FERecommendation} from "../types/fe-recommendation";
import {parseSources} from "./source-parser";
import {Recommendation, Source} from "../types/recommendation";
import {mapRecommendation} from "../mapper/recommendation-mapper";
import {upsertRecommendation} from "../repository/recommendation-repository";

export const processInput = async (event: APIGatewayProxyEvent, client: MongoClient) => {
    console.log(event)
    const db = await client.db(process.env.MONGODB_NAME);

    const userMeta: UserMeta = parseUserMeta(event)
    const feRecommendation: FERecommendation = validateRecommendation(event)
    const sources: Source[] = await parseSources(feRecommendation)
    const recommendation: Recommendation = mapRecommendation(userMeta, feRecommendation, sources)
    return await upsertRecommendation(recommendation, db)
}