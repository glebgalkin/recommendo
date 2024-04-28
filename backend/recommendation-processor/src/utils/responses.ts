import {UpdateResult, Document} from "mongodb";

export const sendSuccessfulResponse = (insertionResult: UpdateResult<Document>) => {
    return {
        statusCode: 202,
        body: JSON.stringify({
            message: insertionResult.upsertedId
        })
    }
}

export const sendErrorResponse = async (error: any) => {
    console.error(error)
    return {
        statusCode: 400,
        body: {
            message: JSON.stringify(error)
        }
    }
}