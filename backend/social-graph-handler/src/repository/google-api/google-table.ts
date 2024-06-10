import {GoogleTable} from "../../types/google-api/google-table";
import {Collection, Db} from "mongodb";
import {GOOGLE_TABLE_COLLECTION} from "../../constants/google-api/collections";

export const upsertGoogleTableRecord = async (googleRecord: GoogleTable, mongoDbConnection: Db) => {
    try {
        const collection: Collection<GoogleTable> = mongoDbConnection.collection<GoogleTable>(GOOGLE_TABLE_COLLECTION);
        const result = await collection.updateOne(
            { _id: googleRecord._id },
            { $set: googleRecord },
            { upsert: true }
        );

        console.log('Upsert successful:', result);
        return result;
    } catch (error) {
        console.error('Error in upsert operation:', error);
        throw error;
    }
}