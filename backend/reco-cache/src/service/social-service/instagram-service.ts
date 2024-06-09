import {FetchSocial, InflateSocial} from "./social-service";
import {IInstagramInfo} from "../../model/repository/social-table/instagram-info";
import {SocialSource} from "../../model/service/social-source";

export const fetchInstagramInfo: FetchSocial = async (instagramId: string): Promise<IInstagramInfo> => {
    // TODO: User pupiter or 3rd party API
    return {
        _id: instagramId,
        name: instagramId,
        originUrl: `instagram/${instagramId}`,
        //description?: string;
        images: [],
        posts: 1,
        followerCount: 1,
        followingCount: 1,
    };
}

export const inflateByInstagram: InflateSocial = async (instagramId: string): Promise<SocialSource[]> => {
    return Promise.resolve([]);
}