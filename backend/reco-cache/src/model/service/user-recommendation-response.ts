import {SocialSource} from "./social-source";
import {SourceType} from "../../types/source-types";

export type FeedItemResponse = {
    name: string;
    socialType: SourceType;
    socialId: string;
    count: string;
    image?: (string | null);
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