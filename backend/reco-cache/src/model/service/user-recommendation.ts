import {SocialSource} from "./social-source";

export type UserRecommendationModel = {
    text: string;
    source: SocialSource;
    cityId: string;
    userId: string;
}
