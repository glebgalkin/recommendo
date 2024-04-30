export type GoogleApiV2Response = {
    accessibilityOptions?: {
        wheelchairAccessibleSeating: boolean;
    };
    addressComponents?: AddressComponent[];
    adrFormatAddress?: string;
    allowsDogs?: boolean;
    businessStatus?: string;
    currentOpeningHours?: {
        openNow: boolean;
        periods: GoogleOpeningHourPeriod[];
        weekdayDescriptions: string[];
    };
    delivery?: boolean;
    dineIn?: boolean;
    displayName?: DisplayText;
    formattedAddress?: string;
    goodForGroups?: boolean;
    goodForWatchingSports?: boolean;
    googleMapsUri: string;
    iconBackgroundColor?: string;
    iconMaskBaseUri?: string;
    id: string;
    internationalPhoneNumber?: string;
    liveMusic?: boolean;
    location: GoogleLocationCoordinates;
    menuForChildren?: boolean;
    name?: string;
    nationalPhoneNumber?: string;
    outdoorSeating?: boolean;
    paymentOptions?: PaymentOptions;
    photos?: PhotoDetail[];
    plusCode?: PlusCode;
    primaryType?: string;
    primaryTypeDisplayName?: DisplayText;
    rating?: number;
    regularOpeningHours?: {
        openNow: boolean;
        periods: GoogleOpeningHourPeriod[];
        weekdayDescriptions: string[];
    };
    reservable?: boolean;
    restroom?: boolean;
    reviews?: ReviewDetail[];
    servesBeer?: boolean;
    servesBreakfast?: boolean;
    servesBrunch?: boolean;
    servesCocktails?: boolean;
    servesCoffee?: boolean;
    servesDessert?: boolean;
    servesLunch?: boolean;
    servesWine?: boolean;
    shortFormattedAddress?: string;
    takeout?: boolean;
    types?: string[];
    userRatingCount?: number;
    utcOffsetMinutes?: number;
    viewport?: Viewport;
    websiteUri?: string;
};


type AddressComponent = {
    languageCode: string;
    longText: string;
    shortText: string;
    types: string[];
};

type GoogleOpeningHourPeriodDetail = {
    day: number;
    hour: number;
    minute: number;
    date?: {
        day: number;
        month: number;
        year: number;
    };
};

type GoogleOpeningHourPeriod = {
    close: GoogleOpeningHourPeriodDetail;
    open: GoogleOpeningHourPeriodDetail;
};

type DisplayText = {
    languageCode: string;
    text: string;
};

type GoogleLocationCoordinates = {
    latitude: number;
    longitude: number;
};

type PaymentOptions = {
    acceptsCashOnly: boolean;
    acceptsCreditCards: boolean;
    acceptsDebitCards: boolean;
    acceptsNfc: boolean;
};

type PhotoDetail = {
    heightPx: number;
    widthPx: number;
    name: string;
    authorAttributions: {
        displayName: string;
        photoUri: string;
        uri: string;
    }[];
};

type PlusCode = {
    compoundCode: string;
    globalCode: string;
};

type ReviewDetail = {
    authorAttribution: {
        displayName: string;
        photoUri: string;
        uri: string;
    };
    name: string;
    originalText: DisplayText;
    publishTime: string;
    rating: number;
    relativePublishTimeDescription: string;
    text: DisplayText;
};

type Viewport = {
    high: GoogleLocationCoordinates;
    low: GoogleLocationCoordinates;
};
