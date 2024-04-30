import {SourceType} from "../source-types";

export interface UserRecommendations {
    _id: string,
    recommendations: RecommendationSource[]
}

export type RecommendationSource = {
    type: SourceType,
    id: string
}