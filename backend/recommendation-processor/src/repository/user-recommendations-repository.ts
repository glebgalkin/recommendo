import {BESource} from "../../../reco-cache/dist/types/be-recommendation";
import {Db} from "mongodb";
import {UserRecommendations} from "../../../reco-cache/dist/types/repository/user-recommendations";
import {USER_RECOS_COLLECTION} from "../constants/mongo-db/mongo-collections";

export const upsertUserRecommendation = async (userId: string, recommendationSource: BESource, mongoConnection: Db) => {
    try {
        const collection = mongoConnection.collection<UserRecommendations>(USER_RECOS_COLLECTION);
        const updateResult = await collection.updateOne(
            { _id: userId },
            { $addToSet: { recommendations: recommendationSource } },
            { upsert: true }
        );
        console.log('Update successful:', updateResult);
        return updateResult;
    } catch (exception) {
        console.error('Error updating user recommendations:', exception);
        throw exception;
    }
}