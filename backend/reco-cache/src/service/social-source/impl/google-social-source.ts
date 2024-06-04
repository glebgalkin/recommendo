import {InflatedSocial, SocialSourceInflation} from "../social-source-inflation";

export const googleSocialSource: SocialSourceInflation = async function(googleId: string): Promise<InflatedSocial[]> {
    return Promise.resolve([]);
}
