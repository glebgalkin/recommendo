import {SourceType} from "./source-types";
import {UserMeta} from "./user-meta";

export type BERecommendation = {
    user: UserMeta
    text: string,
    source: BESource,
    cityId: string,
}

export type BESource = {
    type: SourceType
    id: string
}