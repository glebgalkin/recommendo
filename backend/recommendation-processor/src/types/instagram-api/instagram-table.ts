export type InstagramTable = {
    _id: string,
    instagramProfileId: string,
    bioLinks?: string[]
    biography?: string
    contact: InstagramContact
    category?: string
    externalUrl?: string
    profileInfo: InstagramBasicProfileInfo,
    fullName?: string,
    profilePicture: InstagramProfilePicture,
    location?: InstagramLocation
}

export type InstagramBasicProfileInfo = {
    followers: number,
    following: number,
    posts: number
}

export type InstagramProfilePicture = {
    url: string,
    height: number,
    width: number
}

export type InstagramLocation = {
    streetAddress: string
    cityName: string,
    latitude: number,
    longitude: number,
    zip: string
}

export type InstagramContact = {
    email?: string
    bioEmail?: string,
    phoneNumber?: string,
    publicPhoneNumber?: string
}