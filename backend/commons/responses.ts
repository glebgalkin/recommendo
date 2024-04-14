export const sendSuccessfulResponse = (insertionResult: any) => {
    return {
        statusCode: 202,
        body: JSON.stringify({
            message: insertionResult
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