import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";
import {processRecommendation} from "./service/recommendation-processor";
import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose";


export const lambdaHandler = async (input: BERecommendation) => {
    try{
        await connectDB();
        const result = await processRecommendation(input);
        return sendSuccessfulResponse(JSON.stringify(result));
    } catch (exception){
        return sendErrorResponse(exception);
    }
}
