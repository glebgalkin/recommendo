import {Recommendation} from "../types/recommendation";
import {MongoClient} from "mongodb";

const RECOMMENDATION_COLLECTION = 'recommendations'
export const saveRecommendation = async (recommendation: Recommendation, client: MongoClient) => {
    const db = await client.db(process.env.MONGODB_NAME);
    const collection = await db.collection(RECOMMENDATION_COLLECTION);
    return await collection.insertOne(recommendation);
}