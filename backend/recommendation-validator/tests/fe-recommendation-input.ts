import {SourceType} from "../../reco-cache/dist/types/source-types";

const feRecommendationExampleRequest = {
    title: 'Best coffee shop in town',
    description: 'I highly recommend latte',
    source: [
        {
            type: SourceType.INSTAGRAM,
            id: '49th_mtl'
        }
    ],
    cityId: 'mtl-38937'
}

console.log(JSON.stringify(feRecommendationExampleRequest))