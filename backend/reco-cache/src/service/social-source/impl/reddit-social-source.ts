import {SocialSourceInflation} from "../social-source-inflation";
import {SocialSource} from "../../../model/service/social-source";

export const redditSocialSource: SocialSourceInflation = async (subredditId: string): Promise<SocialSource[]> => {
    return Promise.resolve([]);
}