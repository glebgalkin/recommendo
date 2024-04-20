import {SourceType} from "../constants/source-types";

export type Recommendation = {
    id?: string,
    user: User,
    recommendation: {
        title: string,
        description?: string,
        city: City,
        source: Source[]
    }
}

export type User = {
    id: string,
    email: string
}


export type City = {
    name: string,
    googleId: string
}


export type Source = {
    type: SourceType
    id: string
    extra: GoogleApi | any
}


export type GoogleApi = {
    businessStatus?: string,
    currentOpeningHours?: string[],
    editorialSummary?: GoogleEditorialSummary,
    address?: GoogleAddress,
    phoneNumber?: string,
    internationalPhoneNumber?: string,
    name?: string,
    rating?: number,
    tags?: string[],
    mapUrl?: string,
    userRatingsTotal?: number,
    utcOffset?: number,
}

export type GoogleEditorialSummary = {
    language?: string,
    overview?: string
}



export type GoogleAddress = {
    apartmentUnit?: string,
    street: string,
    city: string,
    province: string,
    postalCode: string,
}