import {SourceType} from "../types/source-types";
import {SocialGraph} from "../model/repository/social-graph";
import {SocialSource} from "../model/service/social-source";

export const mergeSocialGraphsBySocials = async (socials: SocialSource[]) => {
    // gets all social graphs by array of social sources
    const res = await Promise.all(
        socials.map(async s => await findSocialGraphByOneSource(s))
    ).then(e => e
        .flatMap(e => e ? [e] : []));

    // gets randomly (last one) graph as main, so the rest will be merged into this one
    const mainId = res.pop()?._id;
    if (!mainId) return;

    // deletes the rest
    await Promise.all(res.map(e => e.deleteOne().exec()))

    // merges the rest to the main social graph
    await SocialGraph.updateOne(
        {_id: mainId},
        {
            $addToSet: {
                instagramIds: {$each: res.flatMap(e => e.instagramIds)},
                websites: {$each: res.flatMap(e => e.websites)},
                googleMapsIds: {$each: res.flatMap(e => e.googleMapsIds)},
            },
        }).exec();
}

const findSocialGraphByOneSource = (source: SocialSource) => {
    const prop = typeToProperty(source.type);
    const filter = {} as Record<string, string>;
    filter[prop] = source.id;

    return SocialGraph.findOne(filter).exec();
}

const typeToProperty = (type: SourceType): string => {
    switch (type) {
        case SourceType.GOOGLE_API:
            return "googleMapsId";
        case SourceType.INSTAGRAM:
            return "instagramId";
    }
}