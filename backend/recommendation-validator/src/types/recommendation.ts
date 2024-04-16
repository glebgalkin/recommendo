export type FERecommendation = {
    title: string,
    description?: string,
    address?: string,
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
    address: string | null
    socials: {
        instagram: string,
        [social: string]: string,
    },
    city: {
        name: string,
        id: string
    }
}