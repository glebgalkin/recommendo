import {Collection, Db} from "mongodb";
import {RecommendoEntity} from "../../types/entity/recommendo-entity";
import {RECOMMENDO_ENTITY_COLLECTION_NAME} from "../../constants/entity/collections";
import {InstagramTable} from "../../types/instagram-api/instagram-table";

export const updateInstagramInfoUnifyByGoogleId = async (instagram: InstagramTable, googlePlaceId: string, mongoDbConnection: Db) => {
    const collection: Collection<RecommendoEntity> = mongoDbConnection.collection<RecommendoEntity>(RECOMMENDO_ENTITY_COLLECTION_NAME);
    const existingEntity = await collection.findOne({ googlePlaceId: googlePlaceId });
    if(existingEntity){
        return await collection.updateOne(
            { _id: existingEntity._id }, {
                $set: {instagramId: instagram._id},
                $inc: { recommendoCount: 1 },
                $push: { searchKeywords: { $each: [instagram.category]} }
            },
            { upsert: true }
        );
    } else {
        return await saveInstagramEntity(instagram, mongoDbConnection)
    }
}

export const saveInstagramEntity = async (instagramTableRecord: InstagramTable, mongoDbConnection: Db) => {
    const collection: Collection<RecommendoEntity> = mongoDbConnection.collection<RecommendoEntity>(RECOMMENDO_ENTITY_COLLECTION_NAME);
    return await collection.insertOne(
        {
            instagramId: instagramTableRecord._id,
            recommendoCounter: 1,
            searchKeywords: [instagramTableRecord.category]
        }
    )
}