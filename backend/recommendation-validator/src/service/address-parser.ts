import {FERecommendation} from "../types/recommendation";
import {generateGoogleApiUrl} from "../constants/maps";
import axios, {AxiosResponse} from "axios";
import {GoggleApiPlaceInfo} from "../types/google-map-api";
import {SourceType} from "../constants/source-types";

export const getGooglePlaceInfo = async (feRecommendation: FERecommendation): Promise<GoggleApiPlaceInfo | null> => {
    if(feRecommendation.source.type == SourceType.GOOGLE_API && feRecommendation.source.id){
        const googleMapUrl: string = generateGoogleApiUrl(feRecommendation.source.id)
        const response = await axios.get(googleMapUrl)
        return response.data.result ?? null
    } else {
        return null
    }
}