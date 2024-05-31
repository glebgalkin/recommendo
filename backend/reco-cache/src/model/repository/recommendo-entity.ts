import {model, Schema} from 'mongoose';
import {SourceType, typeToProperty} from "../../types/source-types";

interface IRecommendoEntity {
    cityId: string;
    title: string;
    searchText: string;
    instagramId?: string;
    googleMapsId?: string;
    facebookId?: string;
    tags: string[];
}

const recommendoEntitySchema = new Schema<IRecommendoEntity>({
    cityId: {type: String, required: true},
    title: {type: String, required: true},
    searchText: {type: String, required: true},
    instagramId: {type: String, unique: true},
    googleMapsId: {type: String, unique: true},
    facebookId: {type: String, unique: true},
    tags: {type: [String], default: []}
    //organization: { type: Schema.Types.ObjectId, ref: 'Organization' }
});

recommendoEntitySchema.index({searchText: "text", title: "text", tags: "text"});

export const RecommendoEntity = model<IRecommendoEntity>('recommendo_entity', recommendoEntitySchema);

export const findBySocial = (type: SourceType, id: string) => {
    const prop = typeToProperty(type);
    let filter = {} as any;
    filter[prop] = id;

   return RecommendoEntity.findOne(filter).select('_id').exec();
}