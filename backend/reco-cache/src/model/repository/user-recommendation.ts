import {model, Schema, Types} from 'mongoose';
import {SourceType} from "../../types/source-types";

interface IUserRecommendation {
    cityId: string;
    text: string;
    userId: string;
    socialType: SourceType;
    socialId: string;
    recommendoEntity: Types.ObjectId;
    createdAt?: Date;
    updatedAt?: Date;
}

const userRecommendationSchema = new Schema<IUserRecommendation>({
        cityId: {type: String, required: true},
        text: {type: String, required: true},
        userId: {type: String, required: true},
        socialType: {type: String, required: true, enum: SourceType},
        socialId: {type: String, required: true},
        recommendoEntity: {type: Schema.Types.ObjectId, ref: 'recommendo-entity'},
    },
    {timestamps: true}
);

userRecommendationSchema.index({
    userId: 1,
    cityId: 1,
    socialType: 1,
    socialId: 1,
})

export const UserRecommendation = model<IUserRecommendation>('user_recommendation', userRecommendationSchema);
