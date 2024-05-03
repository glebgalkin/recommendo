import {Collection, Db} from "mongodb";
import {RecommendoEntity} from "../../types/entity/recommendo-entity";
import {RECOMMENDO_ENTITY_COLLECTION_NAME} from "../../constants/entity/collections";

export const updateInstagramInfoUnifyByGoogleId = async (recommendoEntity: RecommendoEntity, mongoDbConnection: Db) => {
    const collection: Collection<RecommendoEntity> = mongoDbConnection.collection<RecommendoEntity>(RECOMMENDO_ENTITY_COLLECTION_NAME);
    const existingEntity = await collection.findOne({ googleMapsId: recommendoEntity.googleMapsId });
    if(existingEntity){
        return await collection.updateOne(
            { _id: existingEntity._id }, {
                $set: recommendoEntity,
                $inc: { recommendoCounter: 1 }
            },
            { upsert: true }
        );
    } else {
        return await saveRecommendoEntity(recommendoEntity, mongoDbConnection)
    }
}

export const saveRecommendoEntity = async (recommendoEntity: RecommendoEntity, mongoDbConnection: Db) => {
    const collection: Collection<RecommendoEntity> = mongoDbConnection.collection<RecommendoEntity>(RECOMMENDO_ENTITY_COLLECTION_NAME);
    recommendoEntity.recommendoCounter = 1
    return await collection.insertOne(
        recommendoEntity
    )
}