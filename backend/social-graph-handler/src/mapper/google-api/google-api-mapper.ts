import {Address, BusinessDetails, GoogleTable} from "../../types/google-api/google-table";
import {GoogleApiV2Response} from "../../types/google-api/google-map-api-v2";

export const mapGoogleApiData = (googleData: GoogleApiV2Response): GoogleTable => {
    return {
        _id: googleData.id,
        tags: googleData.types,
        nationalPhoneNumber: googleData.nationalPhoneNumber,
        internationalPhoneNumber: googleData.internationalPhoneNumber,
        location: googleData.location,
        rating: googleData.rating,
        googleMapUri: googleData.googleMapsUri,
        websiteUri: googleData.websiteUri,
        regularOpeningHours: googleData.regularOpeningHours,
        businessStatus: googleData.businessStatus,
        userRatingCount: googleData.userRatingCount,
        displayName: googleData.displayName,
        primaryTypeDisplayName: googleData.primaryTypeDisplayName,
        businessDetails: getBusinessDetails(googleData),
        primaryType: googleData.primaryType,
        address: getAddress(googleData)
    }
}

const getBusinessDetails = (googleData: GoogleApiV2Response): BusinessDetails => {
    return {
        takeout: googleData.takeout,
        delivery: googleData.delivery,
        reservable: googleData.reservable,
        servesBreakfast: googleData.servesBreakfast,
        servesLunch: googleData.servesLunch,
        servesBeer: googleData.servesBeer,
        servesWine: googleData.servesWine,
        servesBrunch: googleData.servesBrunch,
        servesCocktails: googleData.servesCocktails,
        servesDessert: googleData.servesDessert,
        servesCoffee: googleData.servesCoffee,
        allowDogs: googleData.allowsDogs,
        restroom: googleData.restroom,
        goodForGroups: googleData.goodForGroups,
        goodForWatchingSports: googleData.goodForWatchingSports,
        outdoorSeating: googleData.outdoorSeating,
        liveMusic: googleData.liveMusic,
        paymentOptions: googleData.paymentOptions,
        accessibilityOptions: googleData.accessibilityOptions
    }
}

const getAddress = (googleData: GoogleApiV2Response): Address => {
    return {
        formattedAddress: googleData.formattedAddress,
        shortFormattedAddress: googleData.shortFormattedAddress
    }
}