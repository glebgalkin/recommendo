import {Recommendation, Source} from "./recommendation";
import {SourceType} from "../constants/source-types";

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

// Collection per source: instagram, google
export type SocialTable = {
    instagram?: any
    googleMap?: any
}

export type InstagramTable = {
    id: string,
    bioLink?: string[],
    biography?: string,
    category: string,
    contact_phone_number?: string,
    follower_count: number,
    following_count: number,
    full_name?: string,
    profile_image?: string,
    location_data?: {
        address_street?: string,
        city_name?: string,
        latitude?: number,
        longitude?: number,
        postal_code?: string,
    },
    posts: number,
    public_email: string,
    public_phone_country_code?: string,
    public_phone_number?: string,

}




/*
                3 tables:

                FeedRecommendation

                {
                    "cityId": "12345",
                    "instagram": "exampleBistro",
                    "googleMapId": "8PWX7QF2+77",
                    "website": "https://www.examplebistro.com",
                    "businessName": "Example Bistro",
                    "description": "A cozy and inviting place offering a fusion of local and international cuisines.",
                    "image": "https://www.examplebistro.com/image.jpg",
                    "lastCrawledDate": "2024-04-28T00:00:00Z",
                    "recommendoCounter": 150,
                    "tags": ["gourmet", "local", "fusion"]
                }



                Social Instagram table:





 */






