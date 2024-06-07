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

export const saveUserRecommendation = async (ur: CreateUserRecommendationRequest) => {
    const recommendation = await UserRecommendation.findOne(
        {
            userId: ur.userId,
            social: {
                type: ur.source.type,
                id: ur.source.id
            },
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
                social: {
                    type: ur.source.type,
                    id: ur.source.id,
                },
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

export const updateUserRecommendation = async (_id: Types.ObjectId, ur: UpdateUserRecommendationRequest): Promise<boolean> => {
    const result = await UserRecommendation
        .updateOne(
            {_id: _id, userId: ur.userId},
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
                type: e.social.type,
                id: e.social.id,
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


}
