export type FeedRecommendation = {
    cityId: string,
    instagram?: string,
    googleMapId?: string,
    website?: string,
    businessName: string,
    description?: string,
    image?: string,
    lastCrawledDate: Date,
    recommendoCounter: number,
    tags: string[]
}
