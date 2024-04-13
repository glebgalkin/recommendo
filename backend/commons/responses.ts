export const sendSuccessfulResponse = () => {
    return {
        statusCode: 202,
        body: JSON.stringify({
            message: 'Created'
        })
    }
}

export const sendErrorResponse = async (error: string) => {
    console.error(error)
    return {
        statusCode: 400,
        body: error
    }
}