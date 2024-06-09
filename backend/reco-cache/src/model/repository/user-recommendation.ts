import {model, Schema, Types} from 'mongoose';
import {SourceType} from "../../types/source-types";
import {
    GOOGLE_NAPS_INFO_COLLECTION_NAME,
    INSTAGRAM_INFO_COLLECTION_NAME,
    RECOMMENDATION_COLLECTION_NAME
} from "../../constants/repository";

export interface IUserRecommendation {
    cityId: string;
    text: string;
    userId: string;
    socialType: SourceType;
    socialId: Types.ObjectId;
    createdAt?: Date;
    updatedAt?: Date;
}

function typeToModel(type: SourceType) {
    switch (type) {
        case SourceType.GOOGLE_API:
            return GOOGLE_NAPS_INFO_COLLECTION_NAME;
        case SourceType.INSTAGRAM:
            return INSTAGRAM_INFO_COLLECTION_NAME;
    }
}

const userRecommendationSchema = new Schema<IUserRecommendation>({
        cityId: {type: String, required: true},
        text: {type: String, required: true},
        userId: {type: String, required: true},
        socialType: {type: String, required: true, enum: Object.values(SourceType)},
        socialId: {
            type: Schema.Types.ObjectId, ref: function () {
                return typeToModel(this.socialType)
            }
        }

    },
    {timestamps: true}
);

userRecommendationSchema.index({
    userId: 1,
    cityId: 1,
    social: 1,
    text: "text",
})

export const UserRecommendation = model<IUserRecommendation>(RECOMMENDATION_COLLECTION_NAME, userRecommendationSchema);
