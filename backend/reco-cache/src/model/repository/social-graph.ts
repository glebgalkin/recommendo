import {model, Schema} from 'mongoose';
import {SOCIAL_GRAPH_COLLECTION_NAME} from "../../constants/repository";

interface ISocialGraph {
    instagramIds: string[];
    googleMapsIds: string[];
    websites: string[];
    createdAt?: Date;
    updatedAt?: Date;
}

const socialGraphSchema = new Schema<ISocialGraph>({
    instagramIds: {type: [String], unique: true},
    googleMapsIds: {type: [String], unique: true},
    websites: {type: [String], unique: true},
}, {timestamps: true});

socialGraphSchema.index({
    cityIds: 1,
});

export const SocialGraph = model<ISocialGraph>(SOCIAL_GRAPH_COLLECTION_NAME, socialGraphSchema);
