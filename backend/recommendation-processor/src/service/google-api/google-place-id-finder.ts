import {GoogleApiPlaceIdSearchBody} from "../../types/google-api/google-place-id-search";
import axios, {AxiosResponse} from "axios";
import {HttpMethods} from "../../constants/http-methods";
import {GOOGLE_API_V2_REQUEST_HEADERS} from "../../constants/google-api/request-headers";
import {GOOGLE_SEARCH_TEXT_URL} from "../../constants/google-api/url-constants";
import {GoogleApiV2Response} from "../../types/google-api/google-map-api-v2";

export const findGooglePlaceId = async (requestBody: GoogleApiPlaceIdSearchBody): Promise<GoogleApiV2Response|undefined> => {
    const response: AxiosResponse = await axios({
        method: HttpMethods.POST,
        data: requestBody,
        url: GOOGLE_SEARCH_TEXT_URL,
        headers: GOOGLE_API_V2_REQUEST_HEADERS
    });

    if(response.status == 200 && response.data.places && response.data.places.length > 0){
        return response.data.places[0] as GoogleApiV2Response
    } else {
        return undefined
    }
}