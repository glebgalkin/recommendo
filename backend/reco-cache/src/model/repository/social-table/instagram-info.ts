import {model, Schema} from "mongoose";
import {INSTAGRAM_INFO_COLLECTION_NAME} from "../../../constants/repository";
import {ISocialTableBase, socialTableBase} from "./social-table-base";

export interface IInstagramInfo extends ISocialTableBase {
    posts: number;
    followerCount: number;
    followingCount: number;
}

const instagramSchema = new Schema<IInstagramInfo>(
    {
        ...socialTableBase,
        posts: {type: Number, required: true},
        followerCount: {type: Number, required: true},
        followingCount: {type: Number, required: true},
    },
    {timestamps: true}
);

export const InstagramInfo = model<IInstagramInfo>(INSTAGRAM_INFO_COLLECTION_NAME, instagramSchema);
