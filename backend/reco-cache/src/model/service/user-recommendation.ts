import {SourceType} from "../../types/source-types";

export type UserRecommendation = {
    text: string,
    source: Source
}

export type Source = {
    type: SourceType
    id: string
}