export type FERecommendation = {
    title: string,
    description?: string,
    address?: {
        apartmentUnit?: string,
        street: string,
        city: string,
        province: string,
        postalCode: string,
    }
    socials: {
        instagram: string,
        [social: string]: string,
    },
    city: {
        name: string,
        id: string
    }
}

export type Recommendation = {
    userId: string,
    name: string,
    email: string,
    title: string,
    description?: string,
    address: Address | null,
    socials: {
        instagram: string,
        [social: string]: string,
    },
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