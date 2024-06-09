import {SourceType} from "../../types/source-types";
import {ISocialTableBase} from "../../model/repository/social-table/social-table-base";
import {Model} from "mongoose";
import {GoogleMapsInfo} from "../../model/repository/social-table/google-maps-info";
import {InstagramInfo} from "../../model/repository/social-table/instagram-info";
import {fetchGoogleMapsInfo} from "./google-maps-service";
import {fetchInstagramInfo} from "./instagram-service";


export interface GetSocialInfo {
    (id: string): Promise<ISocialTableBase | null>;
}

export interface SaveOrUpdateSocialInfo {
    (id: string): Promise<boolean>;
}

export interface DeleteSocialInfo {
    (id: string): Promise<boolean>;
}

export type FetchSocial = (id: string) => Promise<ISocialTableBase>;


export const getSocialInfo = async (type: SourceType, socialId: string): Promise<ISocialTableBase | null> => {
    switch (type) {
        case SourceType.GOOGLE_API:
            return defaultGetSocial(socialId, GoogleMapsInfo);
        case SourceType.INSTAGRAM:
            return defaultGetSocial(socialId, InstagramInfo);
    }
}

export const deleteSocial = async (type: SourceType, socialId: string): Promise<boolean> => {
    switch (type) {
        case SourceType.GOOGLE_API:
            return defaultDeleteSocial(socialId, GoogleMapsInfo);
        case SourceType.INSTAGRAM:
            return defaultDeleteSocial(socialId, InstagramInfo);
    }
}

export const saveOrUpdateSocial = async (type: SourceType, socialId: string): Promise<boolean> => {
    switch (type) {
        case SourceType.GOOGLE_API:
            return defaultSaveOrUpdate(socialId, GoogleMapsInfo, fetchGoogleMapsInfo);
        case SourceType.INSTAGRAM:
            return defaultSaveOrUpdate(socialId, InstagramInfo, fetchInstagramInfo);
    }
}

async function defaultGetSocial<Type extends ISocialTableBase>(id: string, model: Model<Type>): Promise<ISocialTableBase | null> {
    return model.findOne({id: id}).exec();
}

async function defaultSaveOrUpdate<Type extends ISocialTableBase>(id: string, model: Model<Type>, fetch: FetchSocial): Promise<boolean> {
    const info = await fetch(id);
    const query = {id: id};
    const update = {$set: info};
    const options = {upsert: true};
    const result = await model.updateOne(query, update, options).exec();
    return result.acknowledged && (result.modifiedCount === 1 || result.upsertedCount === 1);

}

async function defaultDeleteSocial<Type extends ISocialTableBase>(id: string, model: Model<Type>): Promise<boolean> {
    const result = await model.deleteOne({id: id}).exec();
    if (!result.acknowledged) return false;
    return result.deletedCount === 1;
}