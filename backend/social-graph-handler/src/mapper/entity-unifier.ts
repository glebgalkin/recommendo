import {GoogleTable} from "../types/google-api/google-table";
import {InstagramTable} from "../types/instagram-api/instagram-table";
import {RecommendoEntity} from "../types/entity/recommendo-entity";

export const convertToInstagramOnlyRecommendo = (instagramTable: InstagramTable, cityId: string): RecommendoEntity => {
    return {
        cityId: cityId,
        instagramId: instagramTable._id,
        businessName: instagramTable.fullName,
        description: instagramTable.biography,
        image: instagramTable.profilePicture.url,
        searchKeywords: [instagramTable.category.toLowerCase()]
    }
}

export const unifyGoogleWithIg = (googleTable: GoogleTable, instagramTable: InstagramTable, cityId: string): RecommendoEntity => {
    return {
        cityId: cityId,
        instagramId: instagramTable._id,
        googleMapsId: googleTable._id,
        businessName: getBusinessName(googleTable, instagramTable),
        image: getImage(googleTable, instagramTable),
        searchKeywords: getSearchKeyWords(googleTable, instagramTable)
    }
}

const getBusinessName = (googleTable: GoogleTable, instagramTable: InstagramTable) => {

    const googleBusinessName = googleTable.displayName?.text
    const instagramBusinessName = instagramTable.fullName

    if(googleBusinessName && instagramBusinessName){
        if (googleBusinessName.toLowerCase().includes(instagramBusinessName.toLowerCase())) {
            return instagramBusinessName;
        }
        if (instagramBusinessName.toLowerCase().includes(googleBusinessName.toLowerCase())) {
            return googleBusinessName;
        }
        return googleBusinessName;
    }

    return googleBusinessName || instagramBusinessName
}

// TODO: Consider adding google images
const getImage = (googleTable: GoogleTable, instagramTable: InstagramTable) => {
    return instagramTable.profilePicture.url
}

// TODO: Consider extracting more tags from other fields
const getSearchKeyWords = (googleTable: GoogleTable, instagramTable: InstagramTable) => {
    const tags = new Set<string>()
    tags.add(instagramTable.category.toLowerCase())
    if(googleTable.tags){
        for(const tag of googleTable.tags){
            tags.add(tag.toLowerCase())
        }
    }
    return Array.from(tags);
}