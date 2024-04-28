import {UserMeta} from "@reco-cache/cache/types/user-meta"
import {BERecommendationDto} from "@reco-cache/cache/types/be-recommendation-dto"
import {FERecommendation} from "@reco-cache/cache/types/fe-recommendation"

export const buildBeRecommendationDto = (feRecommendation: FERecommendation, userMeta: UserMeta): BERecommendationDto => {
    return {
        ...feRecommendation,
        user: userMeta
    }
}