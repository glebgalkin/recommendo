import {SourceType} from "../../types/source-types";

export type UserRecommendationModel = {
    text: string;
    source: Source;
    cityId: string;
    userId: string;
}

export type Source = {
    type: SourceType
    id: string
}