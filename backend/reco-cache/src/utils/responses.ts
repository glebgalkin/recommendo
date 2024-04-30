
export const sendSuccessfulResponse = (result: string) => {
    return {
        statusCode: 202,
        body: JSON.stringify({
            message: result
        })
    }
}

export const sendErrorResponse = async (error: any) => {
    console.error(error)
    const errorResponse = {
        message: error.message
    };
    return {
        statusCode: 400,
        body: JSON.stringify(errorResponse)
    }
}