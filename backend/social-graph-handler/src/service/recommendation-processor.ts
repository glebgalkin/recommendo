import {UserRecommendationModel} from "@reco-cache/cache/model/service/user-recommendation";
import {getInflatedSocials} from "@reco-cache/cache/service/social-source/social-source-inflation";
import {mergeSocialGraphsBySocials} from "@reco-cache/cache/service/recommendo-service";

export const lookupForConnectedSocials = async (urm: UserRecommendationModel) => {

    const socials = await getInflatedSocials(urm.source.type, urm.source.id);
    await mergeSocialGraphsBySocials(socials);
}