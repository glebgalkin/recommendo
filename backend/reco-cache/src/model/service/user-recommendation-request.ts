import {SocialSource} from "./social-source";

export type CreateUserRecommendationRequest = {
    text: string;
    cityId: string;
    userId: string;
    source: SocialSource;
}

export type SearchRecommendationsRequest = {
    offset: number;
    limit: number;
    cityId: string;
    locale: string;
    term?: string;
}

export type UpdateUserRecommendationRequest = {
    id: string;
    userId: string;
    text: string;
}

export type DeleteUserRecommendationRequest = {
    userId: string;
    id: string;
}

export type GetUserRecommendationRequest = {
    userId: string;
    offset: number;
    limit: number;
    locale: string;
}
