import {SourceType} from "@reco-cache/cache/types/source-types";

export type FERecommendation = {
    text: string,
    source: FESource,
    cityId: string
}

export type FESource = {
    type: SourceType
    id: string
}