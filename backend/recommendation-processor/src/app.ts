import {MongoClient} from "mongodb";
import {BERecommendation} from "../../reco-cache/dist/types/be-recommendation-dto";
import {sendErrorResponse, sendSuccessfulResponse} from "../../reco-cache/dist/utils/responses";
import {processRecommendation} from "./service/recommendation-processor";
import {SourceType} from "../../reco-cache/dist/types/source-types";

const client: MongoClient = new MongoClient(process.env.MONGODB_CONNECTION_STRING!);

export const lambdaHandler = async (input: BERecommendation) => {
    try{
        const result = await processRecommendation(input, client)
        return sendSuccessfulResponse("result")
    } catch (exception){
        return sendErrorResponse(exception)
    }
}


