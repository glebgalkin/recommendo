import {UserMeta} from "@reco-cache/cache/types/user-meta";
import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";
import {FERecommendation} from "../types/fe-recommendation";
import {Types} from 'mongoose';


export const buildBeRecommendationDto = (feRecommendation: FERecommendation, userMeta: UserMeta, reId?: Types.ObjectId): BERecommendation => {
    return {
        ...feRecommendation,
        user: userMeta,
        recommendoEntity: reId,
    }
}