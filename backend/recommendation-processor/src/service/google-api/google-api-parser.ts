import {generateGoogleApiUrl} from "../../constants/maps";
import axios from "axios";
import {FESource} from "../../types/fe-recommendation";
import {GoggleApiResponse} from "../../types/google-map-api";
import {GoogleApi, Source} from "../../types/recommendation";
import {getGoogleAddress} from "./google-address-parser";
import {SourceType} from "../../constants/source-types";

export const getGooglePlaceInfo = async (feSource: FESource): Promise<Source|null> => {

    const googleMapUrl: string = generateGoogleApiUrl(feSource.id)
    const response = await axios.get(googleMapUrl)
    if(response.data?.result){
        return {
            type: SourceType.GOOGLE_API,
            id: feSource.id,
            extra: parseGoogleApiResponse(response.data.result)
        }
    }

    return null;
}

const parseGoogleApiResponse = (googleResponse: GoggleApiResponse): GoogleApi => {

    return {
        ...googleResponse.business_status && {businessStatus: googleResponse.business_status},
        ...googleResponse?.current_opening_hours?.weekday_text && { currentOpeningHours: googleResponse.current_opening_hours.weekday_text },
        ...googleResponse.editorial_summary && {editorialSummary: googleResponse.editorial_summary},
        ...googleResponse.formatted_address && {address: getGoogleAddress(googleResponse.formatted_address)},
        ...googleResponse.formatted_phone_number && {phoneNumber: googleResponse.formatted_phone_number},
        ...googleResponse.international_phone_number && {internationalPhoneNumber: googleResponse.international_phone_number},
        ...googleResponse.name && {name: googleResponse.name},
        ...googleResponse.rating && {rating: googleResponse.rating},
        ...googleResponse.types && {tags: googleResponse.types},
        ...googleResponse.url && {mapUrl: googleResponse.url},
        ...googleResponse.user_ratings_total && {userRatingsTotal: googleResponse.user_ratings_total},
        ...googleResponse.utc_offset && {utcOffset: googleResponse.utc_offset},
    }
}