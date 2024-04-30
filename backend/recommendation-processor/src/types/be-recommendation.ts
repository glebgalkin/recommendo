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


/*
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
 */






