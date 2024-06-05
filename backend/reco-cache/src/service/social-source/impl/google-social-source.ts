import {SocialSourceInflation} from "../social-source-inflation";
import {SocialSource} from "../../../model/service/social-source";

export const googleSocialSource: SocialSourceInflation = async function(googleId: string): Promise<SocialSource[]> {
    return Promise.resolve([]);
}
