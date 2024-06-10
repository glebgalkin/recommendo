import {FilterQuery} from "mongoose";
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
            socialId: ur.source.id,
            socialType: ur.source.type,
            cityId: ur.cityId,
        },
    ).exec();
    if (recommendation) {
        // not sure if we will concat text by default
        recommendation.text += `\n${ur.text}`;
        return recommendation.save();
    } else {
        return new UserRecommendation({
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

export const updateUserRecommendation = async (ur: UpdateUserRecommendationRequest): Promise<boolean> => {
    const result = await UserRecommendation
        .updateOne(
            {_id: ur.id, userId: ur.userId},
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
    // TODO: Add city localization
    // TODO: Social lookup to get name of the recommended social
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
    return UserRecommendation.aggregate<FeedItemResponse>([
        {
            $match: filter
        },
        {
            $sort: {updatedAt: -1}
        },
        {
            $group: {
                _id: {socialType: "$socialType", socialId: "$socialId"},
                count: {$sum: 1},
                lastRecommendations: {$push: "$text"},
                lastRecommendedAt: {$max: "$updatedAt"},
            }
        },
        {
            $lookup: {
                from: 'instagram_infos',
                localField: '_id.socialId',
                foreignField: '_id',
                as: 'instagramInfo',
            },
        },
        {
            $lookup: {
                from: 'google_maps_infos',
                localField: '_id.socialId',
                foreignField: '_id',
                as: 'googleMapsInfo',
            },
        },
        {
            $addFields: {
                socialInfo: {
                    $switch: {
                        branches: [
                            {
                                case: {$eq: ['$_id.socialType', 'INSTAGRAM']},
                                then: {$arrayElemAt: ['$instagramInfo', 0]}
                            },
                            {
                                case: {$eq: ['$_id.socialType', 'GOOGLE_API']},
                                then: {$arrayElemAt: ['$googleMapsInfo', 0]}
                            },
                        ],
                        default: null
                    }
                }
            }
        },
        {
            $project: {
                _id: false,
                socialType: "$_id.socialType",
                socialInfo: "$socialInfo",
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
        },
        {
            $limit: searchModel.limit
        }
    ]).exec();
}
