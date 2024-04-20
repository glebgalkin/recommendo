import {UserMeta} from "../types/user-meta";
import {FERecommendation} from "../types/fe-recommendation";
import {GoogleApi, Recommendation, Source} from "../types/recommendation";

export const mapRecommendation = (userMeta: UserMeta, feRecommendation: FERecommendation,
                                  sources: Source[]): Recommendation => {
    return {
        user: {
            id: userMeta.userId,
            email: userMeta.email
        },
        recommendation: {
            title: feRecommendation.title,
            ...feRecommendation.description && {description: feRecommendation.description},
            city: {
                name: feRecommendation.city.name,
                googleId: feRecommendation.city.id
            },
            source: sources
        }
    }
}

