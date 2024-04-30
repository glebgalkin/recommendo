import {BERecommendation, BESource} from "../../../../reco-cache/dist/types/be-recommendation-dto";
import {Db, UpdateResult} from "mongodb";
import {upsertUserRecommendation} from "../../repository/user-recommendations-repository";
import {HttpMethods} from "../../constants/http-methods";
import {INSTAGRAM_API_URL} from "../../constants/instagram-api/url-constants";
import {INSTAGRAM_API_REQUEST_HEADERS} from "../../constants/instagram-api/request-headers";
import axios, {AxiosResponse} from "axios";
import {InstagramApiResponse} from "../../types/instagram-api/instagram-api-response";
import {mapInstagramApiData} from "../../mapper/instagram-api/instagram-api-mapper";
import {InstagramTable} from "../../types/instagram-api/instagram-table";
import {upsertInstagramTableRecord} from "../../repository/instagram-api/instagram-table";

export const processInstagramRecommendation = async (beRecommendation: BERecommendation, mongoDbConnection: Db): Promise<UpdateResult> => {
    const instagramSource: BESource = beRecommendation.source[0]
    const userId: string = beRecommendation.user.userId
    await upsertUserRecommendation(userId, instagramSource, mongoDbConnection)
    const igProfileData: InstagramApiResponse = await getInstagramProfileDetails(instagramSource.id)
    const instagramTableRecord: InstagramTable = mapInstagramApiData(igProfileData)
    const result: UpdateResult<InstagramTable> = await upsertInstagramTableRecord(instagramTableRecord, mongoDbConnection)
    return result
}

const getInstagramProfileDetails = async (instagramId: string): Promise<InstagramApiResponse> => {
    const options = {
        method: HttpMethods.GET,
        url: INSTAGRAM_API_URL,
        params: {
            username_or_id_or_url: instagramId
        },
        headers: INSTAGRAM_API_REQUEST_HEADERS
    };

    const response: AxiosResponse = await axios.request(options);
    return response.data.data as InstagramApiResponse
}