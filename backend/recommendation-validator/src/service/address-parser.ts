import {FERecommendation} from "../types/recommendation";
import {generateGoogleApiUrl} from "../constants/maps";
import axios, {AxiosResponse} from "axios";
import {GoggleApiPlaceInfo} from "../types/google-map-api";




export const getAddress = async (feRecommendation: FERecommendation) => {
    if(feRecommendation.address){
        return feRecommendation.address
    } else {
        try {
            return await getAddressByGoogle(feRecommendation)
        } catch (error){
            console.log(error)
            return null
        }
    }
}

export const getAddressByGoogle = async (feRecommendation: FERecommendation) => {
    const googleMapUrl = generateGoogleApiUrl(feRecommendation.title, feRecommendation.city.name)
    const response = await axios.get(googleMapUrl)
    return parseGoogleApiAddress(response)
}

export const parseGoogleApiAddress = (response: AxiosResponse) => {
    if (response && Array.isArray(response.data?.results) && response.data.results.length > 0) {
        const googleMapResponse: GoggleApiPlaceInfo = response.data?.results[0]
        return googleMapResponse.formatted_address
    }

    return null;
}