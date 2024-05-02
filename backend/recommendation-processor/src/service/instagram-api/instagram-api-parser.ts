import {BERecommendation, BESource} from "../../../../reco-cache/dist/types/be-recommendation";
import {Db, UpdateResult} from "mongodb";
import {upsertUserRecommendation} from "../../repository/user/user-recommendations-repository";
import {HttpMethods} from "../../constants/http-methods";
import {INSTAGRAM_API_URL} from "../../constants/instagram-api/url-constants";
import {INSTAGRAM_API_REQUEST_HEADERS} from "../../constants/instagram-api/request-headers";
import axios, {AxiosResponse} from "axios";
import {InstagramApiResponse} from "../../types/instagram-api/instagram-api-response";
import {mapInstagramApiData} from "../../mapper/instagram-api/instagram-api-mapper";
import {InstagramTable} from "../../types/instagram-api/instagram-table";
import {upsertInstagramTableRecord} from "../../repository/instagram-api/instagram-table";
import {GoogleApiPlaceIdSearchBody} from "../../types/google-api/google-place-id-search";
import {GOOGLE_API_RADIUS_SEARCH} from "../../constants/google-api/radius-search";
import {findGooglePlaceId} from "../google-api/google-place-id-finder";
import {GoogleApiV2Response} from "../../types/google-api/google-map-api-v2";
import {
    saveInstagramEntity,
    updateInstagramInfoUnifyByGoogleId
} from "../../repository/entity/recommendo-entity-repository";

export const processInstagramRecommendation = async (beRecommendation: BERecommendation, mongoDbConnection: Db): Promise<UpdateResult> => {
    const instagramSource: BESource = beRecommendation.source[0]
    const userId: string = beRecommendation.user.userId
    await upsertUserRecommendation(userId, instagramSource, mongoDbConnection)
    const igProfileData: InstagramApiResponse = await getInstagramProfileDetails(instagramSource.id)
    const instagramTableRecord: InstagramTable = mapInstagramApiData(igProfileData)
    const result: UpdateResult<InstagramTable> = await upsertInstagramTableRecord(instagramTableRecord, mongoDbConnection)

    const requestBody: GoogleApiPlaceIdSearchBody = generateGoogleApiRequestBody(instagramTableRecord)
    const googlePlace: GoogleApiV2Response|undefined = await findGooglePlaceId(requestBody)

    if(googlePlace){
        await updateInstagramInfoUnifyByGoogleId(instagramTableRecord, googlePlace.id, mongoDbConnection)
    } else {
        await saveInstagramEntity(instagramTableRecord, mongoDbConnection)
    }

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

const generateGoogleApiRequestBody = (instagramTableRecord: InstagramTable): GoogleApiPlaceIdSearchBody => {
    const textQuery = getTextQuery(instagramTableRecord)
    const locationBias = getLocationBias(instagramTableRecord)
    const requestBody = {
        textQuery: textQuery,
        locationBias: locationBias
    }
    return requestBody
}

const getTextQuery = (instagramTableRecord: InstagramTable) => {
    const address = instagramTableRecord.location?.streetAddress ?? ''
    const cityName = instagramTableRecord.location?.cityName ?? ''
    const phoneNumber = instagramTableRecord.contact.publicPhoneNumber ?? ''
    const category = instagramTableRecord.category ?? ''
    return `${address} ${cityName} ${phoneNumber} ${category}`
}

const getLocationBias = (instagramTableRecord: InstagramTable) => {
    const latitude = instagramTableRecord.location?.latitude
    const longitude = instagramTableRecord.location?.longitude
    if(longitude && latitude){
        return {
            circle: {
                center: {
                    latitude: latitude,
                    longitude: longitude,
                },
                radius: GOOGLE_API_RADIUS_SEARCH
            }
        }
    }
}

