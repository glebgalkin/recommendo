import {InstagramApiResponse} from "../../types/instagram-api/instagram-api-response";
import {
    InstagramBasicProfileInfo, InstagramContact,
    InstagramProfilePicture,
    InstagramTable
} from "../../types/instagram-api/instagram-table";

export const mapInstagramApiData = (instagramApiData: InstagramApiResponse): InstagramTable => {
    return {
        _id: instagramApiData.username,
        instagramProfileId: instagramApiData.id,
        bioLinks: getBioLinks(instagramApiData),
        biography: instagramApiData.biography,
        contact: getContact(instagramApiData),
        category: instagramApiData.category,
        externalUrl: instagramApiData.external_url,
        profileInfo: getProfileInfo(instagramApiData),
        fullName: instagramApiData.full_name,
        profilePicture: getProfilePicture(instagramApiData),
        location: getLocation(instagramApiData),
    }
}

const getBioLinks = (instagramApiData: InstagramApiResponse) => {
    if(instagramApiData.bio_links && instagramApiData.bio_links.length > 0){
        return instagramApiData.bio_links.map(bioLink => bioLink.url)
    }
}

const getContact = (instagramApiData: InstagramApiResponse): InstagramContact => {
    return {
        email: instagramApiData.public_email,
        bioEmail: instagramApiData.biography_email ?? undefined,
        phoneNumber: instagramApiData.contact_phone_number,
        publicPhoneNumber: instagramApiData.public_phone_number
    }
}

const getProfileInfo = (instagramApiData: InstagramApiResponse): InstagramBasicProfileInfo => {
    return {
        followers: instagramApiData.follower_count,
        following: instagramApiData.following_count,
        posts: instagramApiData.media_count
    }
}

const getProfilePicture = (instagramApiData: InstagramApiResponse): InstagramProfilePicture => {
    return {
        url: instagramApiData.hd_profile_pic_url_info.url,
        height: instagramApiData.hd_profile_pic_url_info.height,
        width: instagramApiData.hd_profile_pic_url_info.width,
    }
}

const getLocation = (instagramApiData: InstagramApiResponse) => {
    if(instagramApiData.location_data){
        return {
            streetAddress: instagramApiData.location_data.address_street,
            cityName: instagramApiData.location_data.city_name,
            latitude: instagramApiData.location_data.latitude,
            longitude: instagramApiData.location_data.longitude,
            zip: instagramApiData.location_data.zip
        }
    }
}