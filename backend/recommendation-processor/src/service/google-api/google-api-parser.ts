import axios, {AxiosResponse} from "axios";
import {Db, UpdateResult} from "mongodb";
import {generateGoogleApiUrlV2} from "../../constants/google-api/url-constants";
import {upsertUserRecommendation} from "../../repository/user/user-recommendations-repository";
import {BERecommendation, BESource} from "@reco-cache/cache/types/be-recommendation";
import {mapGoogleApiData} from "../../mapper/google-api/google-api-mapper";
import {GoogleTable} from "../../types/google-api/google-table";
import {GOOGLE_API_V2_REQUEST_HEADERS} from "../../constants/google-api/request-headers";
import {HttpMethods} from "../../constants/http-methods";
import {upsertGoogleTableRecord} from "../../repository/google-api/google-table";
import {GoogleApiV2Response} from "../../types/google-api/google-map-api-v2";

export const processGoogleRecommendation = async (beRecommendation: BERecommendation, mongoDbConnection: Db): Promise<UpdateResult<GoogleTable>> => {
    const googlePlaceSource: BESource = beRecommendation.source
    const userId: string = beRecommendation.user.userId
    await upsertUserRecommendation(userId, googlePlaceSource, mongoDbConnection)
    const googleData: GoogleApiV2Response = await getGooglePlaceIdData(googlePlaceSource.id)
    const googleRecord: GoogleTable = mapGoogleApiData(googleData)
    const result: UpdateResult<GoogleTable> = await upsertGoogleTableRecord(googleRecord, mongoDbConnection)
    console.log(googleRecord, result)
    return result;
}

const getGooglePlaceIdData = async (googlePlaceId: string): Promise<GoogleApiV2Response> => {
    const googleMapUrl: string = generateGoogleApiUrlV2(googlePlaceId)
    const response: AxiosResponse = await axios({
        method: HttpMethods.GET,
        url: googleMapUrl,
        headers: GOOGLE_API_V2_REQUEST_HEADERS
    });
    return response.data as GoogleApiV2Response
}