import {FERecommendation} from "../../../reco-cache/dist/types/fe-recommendation";
import {UserMeta} from "../../../reco-cache/dist/types/user-meta";
import {BERecommendation} from "../../../reco-cache/dist/types/be-recommendation-dto";


export const buildBeRecommendationDto = (feRecommendation: FERecommendation, userMeta: UserMeta): BERecommendation => {
    return {
        ...feRecommendation,
        user: userMeta
    }
}