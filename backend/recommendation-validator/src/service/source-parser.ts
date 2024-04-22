import {FERecommendation} from "../types/fe-recommendation";
import {SourceType} from "../constants/source-types";
import {getGooglePlaceInfo} from "./google-api/google-api-parser";
import {Source} from "../types/recommendation";
import {getInstagramInfo} from "./instagram-scrapper/instagram-scrapper";

export const parseSources = async (feRecommendation: FERecommendation): Promise<Source[]> => {
    const sources = []
    for (const source of feRecommendation.source){
        if(source.type === SourceType.GOOGLE_API){
            const googleSource  = await getGooglePlaceInfo(source)
            if(googleSource){
                sources.push(googleSource)
            }
        }

        else if(source.type === SourceType.INSTAGRAM){
            const instagramSource = await getInstagramInfo(source)
            if(instagramSource){
                sources.push(instagramSource)
            }
        }
    }
    return sources;
}