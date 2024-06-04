import {Schema} from "mongoose";

export interface IPoint {
    type: string;
    coordinates: number[];
}

export const pointSchema = new Schema<IPoint>({
    type: {
        type: String,
        enum: ['Point'],
        required: true
    },
    coordinates: {
        type: [Number],
        required: true
    }
});
