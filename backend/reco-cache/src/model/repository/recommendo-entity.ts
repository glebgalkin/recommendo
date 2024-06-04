import {model, Schema, Types} from 'mongoose';
import {SourceType, typeToProperty} from "../../types/source-types";
import {IPoint, pointSchema} from "./point";

export interface IRecommendoEntity {
    title: string;
    optimizedDescription?: string;
    instagramId?: string;
    googleMapsId?: string;
    facebookId?: string;
    location?: IPoint;
    tags: string[];
}

const recommendoEntitySchema = new Schema<IRecommendoEntity>({
    title: {type: String, required: true},
    optimizedDescription: {type: String},
    instagramId: {type: String, unique: true},
    googleMapsId: {type: String, unique: true},
    facebookId: {type: String, unique: true},
    location: {type: pointSchema},
    tags: {type: [String], default: []}
});

recommendoEntitySchema.index({title: "text", tags: "text", optimizedDescription: "text"});
recommendoEntitySchema.index({location: '2dsphere'});

export const RecommendoEntity = model<IRecommendoEntity>('recommendo_entity', recommendoEntitySchema);
