import {SourceType} from "../constants/source-types";

export type FERecommendation = {
    title: string,
    description?: string,
    source: Source,
    city: {
        name: string,
        id: string
    }
}

export type Source = {
    type: SourceType
    id: string
}

export type Recommendation = {
    userId: string,
    name: string,
    email: string,
    title: string,
    description?: string,
    source: Source,
    address: Address | null,
    city: {
        name: string,
        id: string,
    },
    googleApi: GoogleApi | null;
}

export type GoogleApi = {
    businessStatus: string,
    rating?: number,
    tags?: string[],
    userRatingsTotal?: number
    name?: string
}

export type Address = {
    apartmentUnit?: string,
    street: string,
    city: string,
    province: string,
    postalCode: string,
    providedBy: string
}