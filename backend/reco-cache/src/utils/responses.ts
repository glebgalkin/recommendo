
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
    return {
        statusCode: 400,
        body: {
            message: JSON.stringify(error)
        }
    }
}