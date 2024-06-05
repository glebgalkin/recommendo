import {Types} from "mongoose";
import {RecommendoEntity} from "../model/repository/recommendo-entity";
import {UserRecommendation} from "../model/repository/user-recommendation";
import {optimizeText} from "./text-analyzer-service";
import {SourceType} from "../types/source-types";
import {UserRecommendationModel} from "../model/service/user-recommendation";

export const mergeRecommendoEntities = async (id: Types.ObjectId, ids: Types.ObjectId[]) => {
    const res = await RecommendoEntity.find({_id: {$in: ids}}).exec();
    await RecommendoEntity.deleteMany({_id: {$in: ids}}).exec();

    await RecommendoEntity.updateOne(
        {_id: id},
        {
            $addToSet: {
                tags: {$each: res.flatMap(e => e.tags)},
                cityIds: {$each: res.flatMap(e => e.cityIds)},
                instagramIds: {$each: res.flatMap(e => e.instagramIds)},
                googleMapsIds: {$each: res.flatMap(e => e.googleMapsIds)},
            },
        }).updateOne().exec();

    await UserRecommendation.updateMany({recommendoEntity: {$in: ids}}, {$set: {recommendoEntity: id}}).exec();
}

export const optimizeDescription = async (id: Types.ObjectId): Promise<void> => {
    const re = await RecommendoEntity.findById(id).exec();
    if (!re) return Promise.resolve();

    const userRecommendations = await UserRecommendation
        .find({recommendoEntity: re.id})
        .sort({updatedAt: -1})
        .limit(1000).exec();

    const text = userRecommendations.map(ur => ur.text).join("\n");
    re.optimizedDescription = await optimizeText(text);
    await re.save();
}

export const processUserRecommendation = async (ur: UserRecommendationModel) => {
    const recommendation = await UserRecommendation.findOne(
        {
            userId: ur.userId,
            socialType: ur.source.type,
            socialId: ur.source.id,
            cityId: ur.cityId,
        },
    ).exec();
    if (recommendation) {
        recommendation.text += `\n${ur.text}`;
        await recommendation.save();
        return false;
    }

    const re = await findRecommendoEntityBySocial(ur.source.type, ur.source.id);
    if (re) {
        await new UserRecommendation({
            cityId: ur.cityId,
            text: ur.text,
            userId: ur.userId,
            socialType: ur.source.type,
            socialId: ur.source.id,
            recommendoEntity: re._id,
        }).save();
        return false;
    }

    return true;
}

export const findRecommendoEntityBySocial = (type: SourceType, id: string) => {
    const prop = typeToProperty(type);
    const filter = {} as Record<string, string>;
    filter[prop] = id;

    return RecommendoEntity.findOne(filter).exec();
}

const typeToProperty = (type: SourceType): string => {
    switch (type) {
        case SourceType.GOOGLE_API:
            return "googleMapsId";
        case SourceType.INSTAGRAM:
            return "instagramId";
        case SourceType.REDDIT:
            return "redditId";
    }
}