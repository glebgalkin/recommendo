import {model, Schema} from 'mongoose';

export interface IRecommendoEntity {
    title: string;
    optimizedDescription?: string;
    cityIds: string[];
    instagramIds?: string[];
    googleMapsIds?: string[];
    tags: string[];
    createdAt?: Date;
    updatedAt?: Date;
}

const recommendoEntitySchema = new Schema<IRecommendoEntity>({
        title: {type: String, required: true},
        optimizedDescription: {type: String},
        cityIds: {type: [String]},
        instagramIds: {type: [String], unique: true},
        googleMapsIds: {type: [String], unique: true},
        tags: {type: [String], default: []}
    },
    {timestamps: true});

recommendoEntitySchema.index({
    title: "text",
    tags: "text",
    optimizedDescription: "text",
    cityIds: 1,
});

export const RecommendoEntity = model<IRecommendoEntity>('recommendo_entity', recommendoEntitySchema);
