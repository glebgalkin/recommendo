import {model, Schema} from 'mongoose';
import {SourceType} from "../../types/source-types";
import {RECOMMENDATION_COLLECTION_NAME} from "../../constants/repository";

export interface IUserRecommendation {
    cityId: string;
    text: string;
    userId: string;
    socialType: SourceType;
    socialId: string;
    createdAt?: Date;
    updatedAt?: Date;
}

const userRecommendationSchema = new Schema<IUserRecommendation>({
        cityId: {type: String, required: true},
        text: {type: String, required: true},
        userId: {type: String, required: true},
        socialType: {type: String, required: true, enum: Object.values(SourceType)},
        socialId: {type: String, required: true},
    },
    {timestamps: true}
);

userRecommendationSchema.index({
    userId: 1,
    cityId: 1,
    text: "text",
})

export const UserRecommendation = model<IUserRecommendation>(RECOMMENDATION_COLLECTION_NAME, userRecommendationSchema);
