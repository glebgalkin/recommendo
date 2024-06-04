import {BERecommendation} from "@reco-cache/cache/types/be-recommendation";
import {RecommendoEntity} from "@reco-cache/cache/model/repository/recommendo-entity";
import {UserRecommendation} from "@reco-cache/cache/model/repository/user-recommendation";
import {typeToProperty} from "@reco-cache/cache/types/source-types";


export const processRecommendation = async (beRecommendation: BERecommendation) => {

    console.log(beRecommendation);
    // if (beRecommendation.recommendoEntity) {
    //     const re = await RecommendoEntity.findById(beRecommendation.recommendoEntity).exec();
    //     if (!re) return;
    //     re.searchText += beRecommendation.text;
    //     await re.save();
    // } else {
    //     const doc = {
    //         cityId: beRecommendation.cityId,
    //         title: beRecommendation.source.type + ':' + beRecommendation.source.id,
    //         searchText: beRecommendation.text,
    //     } as any;
    //     const propName = typeToProperty(beRecommendation.source.type);
    //     doc[propName] = beRecommendation.source.id;
    //     const re = new RecommendoEntity(doc);
    //     await re.save();
    //
    //     const ur = new UserRecommendation({
    //         cityId: beRecommendation.cityId,
    //         text: beRecommendation.text,
    //         userId: beRecommendation.user.userId,
    //         recommendoEntity: re.id,
    //     });
    //     await ur.save();
    // }


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

    // if (recommendationType.type === SourceType.GOOGLE_API) {
    //     return await processGoogleRecommendation(beRecommendation, db)
    // } else if (recommendationType.type === SourceType.INSTAGRAM) {
    //     return await processInstagramRecommendation(beRecommendation, db)
    // }
}