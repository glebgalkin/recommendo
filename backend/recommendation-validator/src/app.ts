import {APIGatewayProxyEvent} from "aws-lambda";
import {validateRecommendation} from "./service/recommendation-validator";
import {parseUserMeta} from "./service/user-parser";
import {buildBeRecommendationDto} from "./service/recommendation-mapper";
import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";
import {SUCCESSFUL_ALREADY_CREATED, SUCCESSFUL_RESPONSE} from "./constants/responses";
import {triggerLambda} from "@reco-cache/cache/utils/lambda-trigger";
import {LambdaTriggerType} from "@reco-cache/cache/types/lambda-trigger-type";
import {RECOMMENDATION_PROCESSOR} from "@reco-cache/cache/constants/lambda-names";
import {sendErrorResponse, sendSuccessfulResponse} from "@reco-cache/cache/utils/responses";
import {findBySocial} from "@reco-cache/cache/model/repository/recommendo-entity";
import {UserRecommendation} from "@reco-cache/cache/model/repository/user-recommendation";
import {connectDB} from "@reco-cache/cache/utils/init-mongoose"
import {FERecommendation} from "./types/fe-recommendation";
import {UserMeta} from "@reco-cache/cache/types/user-meta";
import {Types} from 'mongoose';


export const lambdaHandler = async (event: APIGatewayProxyEvent) => {
    try {
        await connectDB(process.env.MONGODB_CONNECTION_STRING!);

        const feRecommendation = validateRecommendation(event);
        const userMeta = parseUserMeta(event);

        // trying to find recommended entity by specified social
        const re = await findBySocial(feRecommendation.source.type, feRecommendation.source.id);
        if (!re) {
            // Completely new place, so it has to be processed
            await processUserRecommendation(feRecommendation, userMeta);
            return sendSuccessfulResponse(SUCCESSFUL_RESPONSE);
        }

        // checking if this place was already recommended
        const ur = await UserRecommendation.findOne({userId: userMeta.userId, recommendoEntity: re._id}).exec();
        if (ur) {
            // Updating recommended text
            ur.text += `\n${feRecommendation.text}`;
            await ur.save();
            return sendSuccessfulResponse(SUCCESSFUL_ALREADY_CREATED);
        }

        // Creating user recommendation for existent place
        const newUr = new UserRecommendation(
            {
                cityId: feRecommendation.cityId,
                text: feRecommendation.text,
                userId: userMeta.userId,
                recommendoEntity: re._id,
            }
        );
        await newUr.save();
        return await processUserRecommendation(feRecommendation, userMeta, re?._id);

    } catch (exception) {
        return sendErrorResponse(exception);
    }
}

async function processUserRecommendation(feRecommendation: FERecommendation, userMeta: UserMeta, recommendoEntityId?: Types.ObjectId) {
    const recommendationDto: BERecommendation = buildBeRecommendationDto(feRecommendation, userMeta, recommendoEntityId);
    return triggerLambda(RECOMMENDATION_PROCESSOR, LambdaTriggerType.Event, recommendationDto);
}
