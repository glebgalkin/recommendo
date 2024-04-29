import {SourceType} from "../source-types";

export interface UserRecommendations {
    _id: string, // user email
    recommendations: RecommendationSource[]
}

export type RecommendationSource = {
    type: SourceType,
    id: string
}