export type RecommendoEntity = {
    cityId?: string,
    instagramId?: string,
    googleMapsId?: string,
    website?: string,
    businessName?: string,
    description?: string,
    image?: string,
    lastCrawledDate?: Date
    recommendoCounter: number,
    searchKeywords: string[]
}