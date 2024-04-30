import {SourceType} from "../constants/source-types";
import {processGoogleRecommendation} from "./google-api/google-api-parser";
import {BERecommendation} from "../../../reco-cache/dist/types/be-recommendation";
import {Db, MongoClient} from "mongodb";
import {processInstagramRecommendation} from "./instagram-api/instagram-api-parser";

export const processRecommendation = async (beRecommendation: BERecommendation, client: MongoClient) => {

    console.log(beRecommendation)

    const db: Db = await client.db(process.env.MONGODB_NAME);
    const recommendationType: SourceType = beRecommendation.source[0].type

    if(recommendationType === SourceType.GOOGLE_API){
        return await processGoogleRecommendation(beRecommendation, db)
    }

    else if(recommendationType === SourceType.INSTAGRAM){
        return await processInstagramRecommendation(beRecommendation, db)
    }
}