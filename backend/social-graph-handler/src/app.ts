import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";
import {lookupForConnectedSocials} from "./service/recommendation-processor";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose";
import {UserRecommendationModel} from "@reco-cache/cache/model/service/user-recommendation";
import {RECOMMENDO_ENTITY_CREATED} from "@reco-cache/cache/constants/responses"


export const handler = async (input: UserRecommendationModel) => {
    try{
        await connectDB(process.env.MONGODB_CONNECTION_STRING!);

        await lookupForConnectedSocials(input);

        return sendSuccessfulResponse(RECOMMENDO_ENTITY_CREATED);
    } catch (exception){
        return sendErrorResponse(exception);
    }
}
