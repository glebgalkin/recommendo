import {Collection, Db} from "mongodb";
import {RecommendoEntity} from "../../types/entity/recommendo-entity";
import {RECOMMENDO_ENTITY_COLLECTION_NAME} from "../../constants/entity/collections";

export const updateRecommendoEntityByGoogleId = async (instagramId: string, googlePlaceId: string, mongoDbConnection: Db) => {
    const collection: Collection<RecommendoEntity> = mongoDbConnection.collection<RecommendoEntity>(RECOMMENDO_ENTITY_COLLECTION_NAME);
    const existingEntity = await collection.findOne({ googlePlaceId: googlePlaceId });
    if(existingEntity){
        return await collection.updateOne(
            { _id: existingEntity._id }, {
                $set: {instagramId: instagramId},
                $inc: { recommendoCount: 1 },
            },
            { upsert: true }
        );
    } else {
        return await collection.insertOne(
            {
                instagramId: instagramId,
                recommendoCounter: 1
            }
        )
    }
}