import {FERecommendation} from "../types/recommendation";
import {generateGoogleApiUrl} from "../constants/maps";
import axios, {AxiosResponse} from "axios";
import {GoggleApiPlaceInfo} from "../types/google-map-api";

export const getGooglePlaceInfo = async (feRecommendation: FERecommendation) => {
    const googleMapUrl = generateGoogleApiUrl(feRecommendation.title, feRecommendation.city.name)
    const response = await axios.get(googleMapUrl)
    return parseGooglePlaceInfo(response)
}

export const parseGooglePlaceInfo = (response: AxiosResponse): GoggleApiPlaceInfo | null => {
    if (response && Array.isArray(response.data?.results) && response.data.results.length > 0) {
        return response.data?.results[0]
    }
    return null;
}