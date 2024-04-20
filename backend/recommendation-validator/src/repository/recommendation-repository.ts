import {Recommendation} from "../types/recommendation";
import {Db, UpdateResult, Document} from "mongodb";

const RECOMMENDATION_COLLECTION = 'recommendations'
export const saveRecommendation = async (recommendation: Recommendation, db: Db) => {
    const collection = await db.collection(RECOMMENDATION_COLLECTION);
    return await collection.insertOne(recommendation);
}

export const upsertRecommendation = async (recommendation: Recommendation, db: Db) => {
    const collection = db.collection('recommendations');
    const filter = {
        "user.id": recommendation.user.id,
        "recommendation.title": recommendation.recommendation.title
    };
    const update = {
        $set: recommendation
    };
    const options = { upsert: true };
    const result = await collection.updateOne(filter, update, options);
    printResult(result)
    return result
}

const printResult = (queryResult: UpdateResult<Document>) => {
    if (queryResult.upsertedCount > 0) {
        console.log('Inserted a new document with id:', queryResult.upsertedId);
    } else if (queryResult.modifiedCount > 0) {
        console.log('Updated an existing document');
    } else {
        console.log('No changes were made to the documents');
    }
}