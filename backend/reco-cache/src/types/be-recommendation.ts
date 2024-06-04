import {SourceType} from "./source-types";
import {UserMeta} from "./user-meta";
import {Types} from 'mongoose';

export type BERecommendation = {
    user: UserMeta
    text: string,
    source: BESource,
    cityId: string,
    recommendoEntity?: Types.ObjectId,
}

export type BESource = {
    type: SourceType
    id: string
}