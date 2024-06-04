import * as mongoose from "mongoose";
import {Types} from "mongoose";
import {IRecommendoEntity, RecommendoEntity} from "../model/repository/recommendo-entity";
import {UserRecommendation} from "../model/repository/user-recommendation";
import {optimizeText} from "./text-analyzer-service";
import {SourceType} from "../types/source-types";

export const mergeTwoRecommendoEntity = async (id1: Types.ObjectId, id2: Types.ObjectId) => {
    const re1 = await RecommendoEntity.findById(id1).exec();
    const re2 = await RecommendoEntity.findById(id2).exec();
    if (!re1 || !re2) {
        return Promise.resolve();
    }

    const tags: Set<string> = new Set(re1.tags);
    re2.tags.forEach(tags.add, tags);

    re1.title = re1.title || re2.title;
    re1.instagramId = re1.instagramId || re2.instagramId;
    re1.facebookId = re1.facebookId || re2.facebookId;
    re1.googleMapsId = re1.googleMapsId || re2.googleMapsId;
    re1.location = re1.location || re2.location;
    re1.optimizedDescription = re1.optimizedDescription || re2.optimizedDescription;
    re1.tags = Array.from(tags);

    await re1.save();

    await UserRecommendation.updateMany({recommendoEntity: re2.id}, {$set: {recommendoEntity: re1.id}}).exec();
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

export const findRecommendoEntityBySocial = (type: SourceType, id: string): Promise<IRecommendoEntity & mongoose.Document | null> => {
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