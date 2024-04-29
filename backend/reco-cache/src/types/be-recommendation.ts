import {SourceType} from "./source-types";
import {UserMeta} from "./user-meta";

export type BERecommendation = {
    user: UserMeta
    title: string,
    description?: string,
    source: BESource[],
    cityId: string,
}

export type BESource = {
    type: SourceType
    id: string
}