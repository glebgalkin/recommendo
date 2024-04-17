import {UserMeta} from "../types/user-meta";
import {Address, FERecommendation, GoogleApi, Recommendation} from "../types/recommendation";
import {GoggleApiPlaceInfo} from "../types/google-map-api";
import {DataProvider} from "../constants/data-provider";

export const mapRecommendation = (userMeta: UserMeta, feRecommendation: FERecommendation,
                                  googlePlaceInfo: GoggleApiPlaceInfo|null): Recommendation => {

    const address: Address|null = getAddress(feRecommendation, googlePlaceInfo)
    const googleApiInfo: GoogleApi|null = parseGoogleApiInfo(googlePlaceInfo)

    return {
        userId: userMeta.userId,
        name: userMeta.name,
        email: userMeta.email,
        title: feRecommendation.title,
        description: feRecommendation.description,
        address: address,
        socials: feRecommendation.socials,
        city: feRecommendation.city,
        googleApi: googleApiInfo
    }
}

const getAddress = (feRecommendation: FERecommendation, googlePlaceInfo: GoggleApiPlaceInfo|null): Address|null => {
    if(feRecommendation.address){
        return {
            street: feRecommendation.address.street,
            city: feRecommendation.address.city,
            province: feRecommendation.address.province,
            postalCode: feRecommendation.address.postalCode,
            providedBy: DataProvider.USER
        }
    } else {
        return getGoogleAddress(googlePlaceInfo)
    }
}

const getGoogleAddress = (googlePlaceInfo: GoggleApiPlaceInfo|null): Address|null => {
    if(googlePlaceInfo){
        const [street, city, provinceWithPostalCode, country] = googlePlaceInfo.formatted_address.split(',')
        const parsedProvince = parseProvinceAndPostalCode(provinceWithPostalCode)
        const trimmedCity = trim(city)
        const trimmedProvince = trim(parsedProvince.province)
        return {
            street: street,
            city: trimmedCity,
            province: trimmedProvince,
            postalCode: parsedProvince.postalCode,
            providedBy: DataProvider.GOOGLE
        }
    } else {
        return null
    }
}

const trim = (value: string) => {
    return value.trimStart().trimEnd()
}

const parseProvinceAndPostalCode = (provinceWithPostalCode: string) => {
    const postalCode = provinceWithPostalCode.substring(provinceWithPostalCode.length-7);
    const province = provinceWithPostalCode.substring(0, provinceWithPostalCode.length-7)
    return {
        province: province,
        postalCode: postalCode
    }
}

const parseGoogleApiInfo = (googlePlaceInfo: GoggleApiPlaceInfo|null): GoogleApi|null => {
    if(googlePlaceInfo){
        return {
            businessStatus: googlePlaceInfo.business_status,
            rating: googlePlaceInfo.rating,
            tags: googlePlaceInfo.types,
            userRatingsTotal: googlePlaceInfo.user_ratings_total,
            name: googlePlaceInfo.name
        }
    } else {
        return null;
    }
}