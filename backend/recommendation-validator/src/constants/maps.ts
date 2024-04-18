const GOOGLE_API_URL = `https://maps.googleapis.com/maps/api/place/details/json?place_id={placeId}&key=${process.env.GOOGLE_MAPS_API_KEY}`
export const generateGoogleApiUrl = (placeId: string) => {
    return GOOGLE_API_URL.replace('{placeId}', placeId)
}
