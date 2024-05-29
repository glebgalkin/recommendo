import {MongoClient} from "mongodb";
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";
import {processRecommendation} from "./service/recommendation-processor";
import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";

const client: MongoClient = new MongoClient(process.env.MONGODB_CONNECTION_STRING!);

export const lambdaHandler = async (input: BERecommendation) => {
    try{
        const result = await processRecommendation(input, client)
        return sendSuccessfulResponse(JSON.stringify(result))
    } catch (exception){
        return sendErrorResponse(exception)
    }
}
