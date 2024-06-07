import {SocialSource} from "./social-source";

export type FeedItemResponse = {
    socialType: string;
    socialId: string;
    count: string;
    image?: string;
    lastRecommendations: string[];
    lastRecommendedAt: Date;
}
export type UserRecommendationResponse = {
    id: string;
    city: City;
    text: string;
    social: SocialSource;
}

export type City = {
    id: string;
    name: string;
}