import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";

export const processRecommendation = async (beRecommendation: BERecommendation) => {

    console.log(beRecommendation)

    // check if recommendation entity exists
    // checking by source type and id
    // if exists -- count++. DONE.

    // else

    // inflate socials by current social
    // get all recommendation entities by socials
    // if 0 -- create recommendation entity. DONE
    // if 1 -- counter++. DONE.
    // else -- log and ignore. DONE.

    // REPOSITORY for user recommendations
    // REPOSITORY for recommendation entities
    // abstract inflate method


    const recommendationType = beRecommendation.source;


    // if (recommendationType.type === SourceType.GOOGLE_API) {
    //     return await processGoogleRecommendation(beRecommendation, db)
    // } else if (recommendationType.type === SourceType.INSTAGRAM) {
    //     return await processInstagramRecommendation(beRecommendation, db)
    // }
}