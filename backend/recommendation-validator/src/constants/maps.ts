export const generateGoogleApiUrl = (placeId: string) => {
    const GOOGLE_API_URL = `https://maps.googleapis.com/maps/api/place/details/json?place_id={placeId}&key=${process.env.GOOGLE_MAPS_API_KEY}`
    return GOOGLE_API_URL.replace('{placeId}', placeId)
}
