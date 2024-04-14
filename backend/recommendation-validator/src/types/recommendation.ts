export type FERecommendation = {
    title: string,
    description?: string,
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
    socials: {
        instagram: string,
        [social: string]: string,
    },
    city: {
        name: string,
        id: string
    }
}