import {model, Schema} from "mongoose";
import {GOOGLE_NAPS_INFO_COLLECTION_NAME} from "../../../constants/repository";
import {defaultOptions, ISocialTableBase, socialTableBase} from "./social-table-base";

export interface IGoogleMapsInfo extends ISocialTableBase {
    reviewsCount: number;
    googleMapsRating: number;
}

const googleMapsSchema = new Schema<IGoogleMapsInfo>(
    {
        ...socialTableBase,
        reviewsCount: {type: Number, required: true},
        googleMapsRating: {type: Number, required: true},
    },
    defaultOptions,
);

export const GoogleMapsInfo = model<IGoogleMapsInfo>(GOOGLE_NAPS_INFO_COLLECTION_NAME, googleMapsSchema);
