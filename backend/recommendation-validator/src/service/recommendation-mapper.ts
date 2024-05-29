import {UserMeta} from "@reco-cache/cache/types/user-meta";
import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";
import {FERecommendation} from "../types/fe-recommendation";


export const buildBeRecommendationDto = (feRecommendation: FERecommendation, userMeta: UserMeta): BERecommendation => {
    return {
        ...feRecommendation,
        user: userMeta
    }
}