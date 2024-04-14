import {UserMeta} from "../types/user-meta";
import {FERecommendation, Recommendation} from "../types/recommendation";

export const mapRecommendation = (userMeta: UserMeta, feRecommendation: FERecommendation): Recommendation => {
    return {
        userId: userMeta.user_id,
        name: userMeta.name,
        email: userMeta.email,
        title: feRecommendation.title,
        description: feRecommendation.description,
        socials: feRecommendation.socials,
        city: feRecommendation.city
    }
}