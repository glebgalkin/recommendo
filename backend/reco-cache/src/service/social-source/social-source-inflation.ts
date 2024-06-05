import {SourceType} from "../../types/source-types";
import {googleSocialSource} from "./impl/google-social-source";
import {instagramSocialSource} from "./impl/instagram-social-source";
import {redditSocialSource} from "./impl/reddit-social-source";
import {SocialSource} from "../../model/service/social-source";

export interface SocialSourceInflation {
    (id: string): Promise<SocialSource[]>;
}

export const getInflatedSocials = async (type: SourceType, socialId: string): Promise<SocialSource[]> => {
    switch (type) {
        case SourceType.GOOGLE_API:
            return googleSocialSource(socialId);
        case SourceType.INSTAGRAM:
            return instagramSocialSource(socialId);
        case SourceType.REDDIT:
            return redditSocialSource(socialId);
    }
}
