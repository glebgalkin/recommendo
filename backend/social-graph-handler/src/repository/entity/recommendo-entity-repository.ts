import {Collection, Db, WithId} from "mongodb";
import {RecommendoEntity} from "../../types/entity/recommendo-entity";
import {RECOMMENDO_ENTITY_COLLECTION_NAME} from "../../constants/entity/collections";
import {SourceType} from "../../constants/source-types";

export class RecommendoEntityRepository {

    private readonly collection: Collection<RecommendoEntity>;

    constructor(mongoConnection: Db, tableName = RECOMMENDO_ENTITY_COLLECTION_NAME) {
        this.collection = mongoConnection.collection(tableName);
    }

    saveRecommendoEntity(recommendoEntity: RecommendoEntity) {
        return this.collection.insertOne(recommendoEntity);
    }

    findBySocialId(socialType: SourceType, socialId: string): Promise<WithId<RecommendoEntity> | null> {
        const propName: string = socialType === SourceType.GOOGLE_API ? 'googleMapsId' : 'googleMapsId';
        let filter: any = {};
        filter[propName] = socialId;
        return this.collection.findOne(filter)
    }

    incrementCounter(recommendoEntity: WithId<RecommendoEntity>) {
        return this.collection.updateOne(
            {_id: recommendoEntity._id}, {
                $set: recommendoEntity,
                $inc: {recommendoCounter: 1}
            }
        );
    }
}


export const updateInstagramInfoUnifyByGoogleId = async (recommendoEntity: RecommendoEntity, mongoDbConnection: Db) => {
    const collection: Collection<RecommendoEntity> = mongoDbConnection.collection<RecommendoEntity>(RECOMMENDO_ENTITY_COLLECTION_NAME);
    const existingEntity = await collection.findOne({googleMapsId: recommendoEntity.googleMapsId});
    if (existingEntity) {
        return await collection.updateOne(
            {_id: existingEntity._id}, {
                $set: recommendoEntity,
                $inc: {recommendoCounter: 1}
            },
            {upsert: true}
        );
    } else {
        return await saveRecommendoEntity(recommendoEntity, mongoDbConnection)
    }
}

export const saveRecommendoEntity = async (recommendoEntity: RecommendoEntity, mongoDbConnection: Db) => {
    const collection: Collection<RecommendoEntity> = mongoDbConnection.collection<RecommendoEntity>(RECOMMENDO_ENTITY_COLLECTION_NAME);
    recommendoEntity.recommendoCounter = 1;
    return await collection.insertOne(
        recommendoEntity
    )
}