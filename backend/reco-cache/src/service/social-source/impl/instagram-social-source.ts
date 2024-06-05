import {SocialSourceInflation} from "../social-source-inflation";
import {SocialSource} from "../../../model/service/social-source";

export const instagramSocialSource: SocialSourceInflation = async (subredditId: string): Promise<SocialSource[]> => {
    return Promise.resolve([]);
}