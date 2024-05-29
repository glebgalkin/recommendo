import {SourceType} from "@reco-cache/cache/types/source-types";

export type FERecommendation = {
    title: string,
    description?: string,
    source: FESource[],
    cityId: string
}

export type FESource = {
    type: SourceType
    id: string
}