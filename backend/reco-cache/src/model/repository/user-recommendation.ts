import {model, Schema} from 'mongoose';
import {SourceType} from "../../types/source-types";
import {USER_RECOMMENDATION_TABLE_NAME} from "../../constants/repository";

interface ISocial {
    type: SourceType;
    id: string;
}

export interface IUserRecommendation {
    cityId: string;
    text: string;
    userId: string;
    social: ISocial;
    createdAt?: Date;
    updatedAt?: Date;
}

const socialSchema = new Schema<ISocial>({
    type: {type: String, required: true, enum: SourceType},
    id: {type: String, required: true},
});

const userRecommendationSchema = new Schema<IUserRecommendation>({
        cityId: {type: String, required: true},
        text: {type: String, required: true},
        userId: {type: String, required: true},
        social: {type: socialSchema, required: true},
    },
    {timestamps: true}
);

userRecommendationSchema.index({
    userId: 1,
    cityId: 1,
    social: 1,
    text: "text",
})

export const UserRecommendation = model<IUserRecommendation>(USER_RECOMMENDATION_TABLE_NAME, userRecommendationSchema);
