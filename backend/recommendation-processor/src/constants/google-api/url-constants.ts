const GOOGLE_API_URL_V1 = `https://maps.googleapis.com/maps/api/place/details/json?place_id={placeId}&key=${process.env.GOOGLE_MAPS_API_KEY}`
const GOOGLE_API_URL_V2 = `https://places.googleapis.com/v1/places/{placeId}`

export const generateGoogleApiUrl = (placeId: string) => {
    return GOOGLE_API_URL_V1.replace('{placeId}', placeId)
}

export const generateGoogleApiUrlV2 = (placeId: string) => {
    return GOOGLE_API_URL_V2.replace('{placeId}', placeId)
}
