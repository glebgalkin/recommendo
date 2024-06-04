import {InflatedSocial, SocialSourceInflation} from "../social-source-inflation";

export const redditSocialSource: SocialSourceInflation = async (subredditId: string): Promise<InflatedSocial[]> => {
    return Promise.resolve([]);
}