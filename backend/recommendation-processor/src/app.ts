import {MongoClient} from "mongodb";
import {sendErrorResponse, sendSuccessfulResponse} from "../../reco-cache/dist/utils/responses";
import {processRecommendation} from "./service/recommendation-processor";
import {BERecommendation} from "../../reco-cache/dist/types/be-recommendation";
import {SourceType} from "../../reco-cache/dist/types/source-types";

const client: MongoClient = new MongoClient(process.env.MONGODB_CONNECTION_STRING!);

export const lambdaHandler = async (input: BERecommendation) => {
    try{
        const result = await processRecommendation(input, client)
        return sendSuccessfulResponse(JSON.stringify(result))
    } catch (exception){
        return sendErrorResponse(exception)
    }
}


lambdaHandler({
    cityId: "someCityId",
    user: {
        email: "sam@gmail.com",
        userId: "someUserId",
    },
    title: "Best place to buy coffe",
    description: "Very good latte",
    source: [{
        type: SourceType.INSTAGRAM,
        id: '49th_mtl'
    }]
})