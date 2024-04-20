import {sendErrorResponse, sendSuccessfulResponse} from "./utils/responses";
import { APIGatewayProxyEvent } from 'aws-lambda';
import {processInput} from "./service/input-processor";
import {MongoClient, UpdateResult, Document} from "mongodb";

const client: MongoClient = new MongoClient(process.env.MONGODB_CONNECTION_STRING!);

export const lambdaHandler = async (event: APIGatewayProxyEvent) => {
    try{
        const result = await processInput(event, client)
        return sendSuccessfulResponse(result)
    } catch (exception){
        return sendErrorResponse(exception)
    }
}
