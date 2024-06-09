import {FilterQuery, Types} from "mongoose";
import {IUserRecommendation, UserRecommendation} from "../model/repository/user-recommendation";
import {FeedItemResponse, UserRecommendationResponse} from "../model/service/user-recommendation-response";
import {
    CreateUserRecommendationRequest,
    DeleteUserRecommendationRequest,
    GetUserRecommendationRequest,
    SearchRecommendationsRequest,
    UpdateUserRecommendationRequest
} from "../model/service/user-recommendation-request";
import {getSocialInfo} from "./social-service/social-service";

export const saveUserRecommendation = async (ur: CreateUserRecommendationRequest) => {
    const recommendation = await UserRecommendation.findOne(
        {
            userId: ur.userId,
            socialId: ur.source.id,
            socialType: ur.source.type,
            cityId: ur.cityId,
        },
    ).exec();
    if (recommendation) {
        // not sure if we will concat text by default
        recommendation.text += `\n${ur.text}`;
        await recommendation.save();
    } else {
        await new UserRecommendation({
                userId: ur.userId,
                socialId: ur.source.id,
                socialType: ur.source.type,
                cityId: ur.cityId,
                text: ur.text,
            }
        ).save();
    }
}

export const deleteUserRecommendation = async (request: DeleteUserRecommendationRequest): Promise<boolean> => {
    const result = await UserRecommendation
        .deleteOne({_id: request.id, userId: request.userId})
        .exec();
    if (!result.acknowledged) return false;
    return result.deletedCount === 1;
}

export const updateUserRecommendation = async (id: string, ur: UpdateUserRecommendationRequest): Promise<boolean> => {
    const result = await UserRecommendation
        .updateOne(
            {_id: id, userId: ur.userId},
            {text: ur.text}
        ).exec();
    if (!result.acknowledged) return false;
    return result.modifiedCount === 1;
}

export const getUserRecommendations = async (request: GetUserRecommendationRequest): Promise<UserRecommendationResponse[]> => {
    const urs = await UserRecommendation
        .find({userId: request.userId})
        .sort({updatedAt: -1})
        .skip(request.offset)
        .limit(request.limit).exec();

    return urs.map(e => {
        return {
            id: e.id,
            city: {
                id: e.cityId,
                name: e.cityId,
            },
            text: e.text,
            social: {
                type: e.socialType,
                id: e.socialId.toString(),
            },
        }
    })
}

export const searchUserRecommendations = async (searchModel: SearchRecommendationsRequest) => {
    const filter = {
        cityId: searchModel.cityId,
    } as FilterQuery<IUserRecommendation>;
    if (searchModel.term) {
        filter.$text = {$search: searchModel.term};
    }
    const result = await UserRecommendation.aggregate<FeedItemResponse>([
        {
            $match: filter
        },
        {
            $sort: {updatedAt: -1}
        },
        {
            $group: {
                _id: {socialType: "$social.socialType", socialId: "$social.socialId"},
                count: {$sum: 1},
                lastRecommendations: {$push: "$text"},
                lastRecommendedAt: {$max: "$updatedAt"},
            }
        },
        {
            $project: {
                socialType: "$_id.socialType",
                socialId: "$_id.socialId",
                count: "$count",
                lastRecommendations: {$slice: ["$lastRecommendations", 10]},
                lastRecommendedAt: "$lastRecommendedAt"
            }
        },
        {
            $sort: {count: -1}
        },
        {
            $skip: searchModel.offset,
            $limit: searchModel.limit
        }
    ]).exec();
    // TODO: Rewrite to lookup or populate
    for (const e of result) {
        const socialInfo = await getSocialInfo(e.socialType, e.socialId);
        e.name = socialInfo!.name;
        e.image = socialInfo?.images[0];
    }
}
