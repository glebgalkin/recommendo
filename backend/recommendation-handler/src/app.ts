import {APIGatewayProxyEvent} from "aws-lambda";
import {parseUserRecommendationRequest} from "./service/recommendation-validator";
import {triggerLambda} from "@reco-cache/cache/utils/lambda-trigger";
import {RECOMMENDATION_PROCESSOR} from "@reco-cache/cache/constants/lambda-names";
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";
import {SUCCESSFUL_RESPONSE} from "@reco-cache/cache/constants/responses";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose"
import {
    deleteUserRecommendation,
    getUserRecommendations,
    saveUserRecommendation,
    updateUserRecommendation
} from "@reco-cache/cache/service/recommendo-service";
import {LambdaTriggerType} from "@reco-cache/cache/types/lambda-trigger-type";

export const handler = async (event: APIGatewayProxyEvent) => {
    try {
        await connectDB(process.env.MONGODB_CONNECTION_STRING!);

        switch (event.httpMethod) {
            case 'GET':
                return handleGet(event);
            case 'POST':
                return handlePost(event);
            case 'PUT':
                return handlePut(event);
            case 'DELETE':
                return handleDelete(event);
            default:
                return {
                    statusCode: 405,
                    body: JSON.stringify({message: 'Method Not Allowed'}),
                };
        }
    } catch (exception) {
        return sendErrorResponse(exception);
    }
}


const handleGet = async (event: APIGatewayProxyEvent) => {
    // TODO: Add parsing
    const userRecommendationModel = parseUserRecommendationRequest(event);

    const result = await getUserRecommendations({});


    return sendSuccessfulResponse(SUCCESSFUL_RESPONSE);
}

const handlePost = async (event: APIGatewayProxyEvent) => {
    const userRecommendationModel = parseUserRecommendationRequest(event);

    await saveUserRecommendation(userRecommendationModel);

    await triggerLambda(RECOMMENDATION_PROCESSOR, LambdaTriggerType.Event, userRecommendationModel);

    return sendSuccessfulResponse(SUCCESSFUL_RESPONSE);
}

const handlePut = async (event: APIGatewayProxyEvent) => {
    // TODO: Add parsing methods
    const userRecommendationModel = parseUserRecommendationRequest(event);
    const id = event.path;
    const result = await updateUserRecommendation(id, userRecommendationModel);

    if (result) {
        return sendSuccessfulResponse(SUCCESSFUL_RESPONSE);
    } else {
        return sendErrorResponse('Error');
    }
}

const handleDelete = async (event: APIGatewayProxyEvent) => {
    // TODO: Add parsing methods
    const userId = event.path;
    const id = event.path;
    const result = await deleteUserRecommendation({id: id, userId: userId});

    if (result) {
        return sendSuccessfulResponse(SUCCESSFUL_RESPONSE);
    } else {
        return sendErrorResponse('Error');
    }
}
