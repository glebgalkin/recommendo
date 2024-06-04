import {InflatedSocial, SocialSourceInflation} from "../social-source-inflation";

export const instagramSocialSource: SocialSourceInflation = async (subredditId: string): Promise<InflatedSocial[]> => {
    return Promise.resolve([]);
}