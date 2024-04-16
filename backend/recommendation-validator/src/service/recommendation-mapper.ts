import {UserMeta} from "../types/user-meta";
import {FERecommendation, Recommendation} from "../types/recommendation";

export const mapRecommendation = (userMeta: UserMeta, feRecommendation: FERecommendation,
                                  address: string|null): Recommendation => {
    return {
        userId: userMeta.user_id,
        name: userMeta.name,
        email: userMeta.email,
        title: feRecommendation.title,
        description: feRecommendation.description,
        address: address ?? null,
        socials: feRecommendation.socials,
        city: feRecommendation.city
    }
}