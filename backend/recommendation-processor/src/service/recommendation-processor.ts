import {UserRecommendationModel} from "@reco-cache/cache/model/service/user-recommendation";

export const lookupForRecommendoEntities = async (urm: UserRecommendationModel) => {


    // inflate socials by current social
    // get all recommendation entities by socials
    // if 0 -- create recommendation entity. DONE
    // if 1 -- counter++. DONE.
    // else -- log and ignore. DONE.

    // REPOSITORY for user recommendations
    // REPOSITORY for recommendation entities
    // abstract inflate method

    // if (recommendationType.type === SourceType.GOOGLE_API) {
    //     return await processGoogleRecommendation(beRecommendation, db)
    // } else if (recommendationType.type === SourceType.INSTAGRAM) {
    //     return await processInstagramRecommendation(beRecommendation, db)
    // }
}