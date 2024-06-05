import {UserRecommendationModel} from "@reco-cache/cache/model/service/user-recommendation";
import {getInflatedSocials} from "@reco-cache/cache/service/social-source/social-source-inflation";
import {findRecommendoEntityBySocial, mergeRecommendoEntities} from "@reco-cache/cache/service/recommendo-service";

export const lookupForRecommendoEntities = async (urm: UserRecommendationModel) => {

    const socials = await getInflatedSocials(urm.source.type, urm.source.id);

    const ids = await Promise.all(
        socials.map(async s => await findRecommendoEntityBySocial(s.type, s.id))
    ).then(e => e
        .map(e => e?._id)
        .flatMap(e => e ? [e] : []));


    await mergeRecommendoEntities(ids);
}