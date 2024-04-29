import {SourceType} from "../../reco-cache/dist/types/source-types";
import {lambdaHandler} from "./app";

lambdaHandler({
    cityId: "someCityId",
    user: {
        email: "sam@gmail.com",
        userId: "someUserId",
    },
    title: "Best place to buy coffe",
    description: "Very good latte",
    source: [{
        type: SourceType.GOOGLE_API,
        id: 'ChIJUVzGJd8byUwRD5ULpyZm6Uk'
    }]
})