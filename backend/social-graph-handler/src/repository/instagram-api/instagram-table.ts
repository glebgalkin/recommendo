import {InstagramTable} from "../../types/instagram-api/instagram-table";
import {Collection, Db, UpdateResult} from "mongodb";
import {INSTAGRAM_TABLE_COLLECTION} from "../../constants/instagram-api/collections";

export const upsertInstagramTableRecord = async (instagramTableRecord: InstagramTable, mongoDbConnection: Db): Promise<UpdateResult<InstagramTable>> => {
    try {
        const collection: Collection<InstagramTable> = mongoDbConnection.collection<InstagramTable>(INSTAGRAM_TABLE_COLLECTION);
        const result: UpdateResult<InstagramTable> = await collection.updateOne(
            { _id: instagramTableRecord._id },
            { $set: instagramTableRecord },
            { upsert: true }
        );

        console.log('Upsert successful:', result);
        return result;
    } catch (error) {
        console.error('Error in upsert operation:', error);
        throw error;
    }
}