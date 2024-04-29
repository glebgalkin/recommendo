import {SourceType} from "../constants/source-types";
import {processGoogleRecommendation} from "./google-api/google-api-parser";
import {BERecommendation} from "../../../reco-cache/dist/types/be-recommendation-dto";
import {MongoClient} from "mongodb";

export const processRecommendation = async (beRecommendation: BERecommendation, client: MongoClient) => {

    const db = await client.db(process.env.MONGODB_NAME);
    const recommendationType: SourceType = beRecommendation.source[0].type

    if(recommendationType === SourceType.GOOGLE_API){
        return await processGoogleRecommendation(beRecommendation, db)
    }

    else if(recommendationType === SourceType.INSTAGRAM){
        //return await processInstaRecommendation(beRecommendation)
    }
}