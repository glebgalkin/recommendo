import {BESource} from "@reco-cache/cache/types/be-recommendation";
import {Collection, Db} from "mongodb";
import {UserRecommendations} from "@reco-cache/cache/types/repository/user-recommendations";
import {USER_RECOS_COLLECTION} from "../../constants/mongo-db/mongo-collections";

export class UserRecommendationsRepository {

    private readonly collection: Collection<UserRecommendations>;

    constructor(mongoConnection: Db, tableName = USER_RECOS_COLLECTION) {
        this.collection = mongoConnection.collection(tableName);
    }

    // Returns true if it's new record
    // Returns false if it's existent record
    async upsertUserRecommendation(userId: string, recommendationSource: BESource): Promise<boolean> {
        try {
            const updateResult = await this.collection.updateOne(
                {_id: userId},
                {$addToSet: {recommendations: recommendationSource}},
                {upsert: true}
            );
            console.log('Update successful:', updateResult);
            return updateResult.modifiedCount !== 0;
        } catch (exception) {
            console.error('Error updating user recommendations:', exception);
            throw exception;
        }
    }

}

export const upsertUserRecommendation = async (userId: string, recommendationSource: BESource, mongoConnection: Db) => {
    try {
        const collection = mongoConnection.collection<UserRecommendations>(USER_RECOS_COLLECTION);
        const updateResult = await collection.updateOne(
            {_id: userId},
            {$addToSet: {recommendations: recommendationSource}},
            {upsert: true}
        );
        console.log('Update successful:', updateResult);
        return updateResult;
    } catch (exception) {
        console.error('Error updating user recommendations:', exception);
        throw exception;
    }
}
