import {SourceType} from "../constants/source-types";

export type FERecommendation = {
    title: string,
    description?: string,
    source: FESource[],
    city: {
        name: string,
        id: string
    }
}

export type FESource = {
    type: SourceType
    id: string
}