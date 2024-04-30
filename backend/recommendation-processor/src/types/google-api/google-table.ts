export type GoogleTable = {
    _id: string,
    tags?: string[]
    nationalPhoneNumber?: string
    internationalPhoneNumber?: string
    location: LocationCoordinates
    rating?: number
    googleMapUri: string
    websiteUri?: string
    regularOpeningHours?: {
        openNow: boolean;
        periods: OpeningHourPeriod[]
    }
    businessStatus?: string
    userRatingCount?: number
    displayName?: {
        text: string
        languageCode: string
    }
    primaryTypeDisplayName?: {
        text: string,
        languageCode: string
    }
    businessDetails?: BusinessDetails,
    primaryType?: string
    address: Address
}

export type LocationCoordinates = {
    latitude: number;
    longitude: number;
}

export type OpeningHourPeriod = {
    close: OpeningHourPeriodDetail;
    open: OpeningHourPeriodDetail;
};

type OpeningHourPeriodDetail = {
    day: number;
    hour: number;
    minute: number;
    date?: {
        day: number;
        month: number;
        year: number;
    };
};

export type BusinessDetails = {
    takeout?: boolean
    delivery?: boolean
    reservable?: boolean
    servesBreakfast?: boolean
    servesLunch?: boolean
    servesBeer?: boolean
    servesWine?: boolean
    servesBrunch?: boolean
    servesCocktails?: boolean
    servesDessert?: boolean
    servesCoffee?: boolean
    allowDogs?: boolean
    restroom?: boolean
    goodForGroups?: boolean
    goodForWatchingSports?: boolean
    outdoorSeating?: boolean
    liveMusic?: boolean,
    paymentOptions?: {
        acceptsCreditCards?: boolean,
        acceptsDebitCards?: boolean,
        acceptsCashOnly?: boolean,
        acceptsNfc?: boolean
    }
    accessibilityOptions?: {
        wheelchairAccessibleSeating?: boolean
    }
}

export type Address = {
    formattedAddress?: string
    shortFormattedAddress?: string
}