const GOOGLE_API_URL = `https://maps.googleapis.com/maps/api/place/textsearch/json?query={title}+in+{city}&key=${process.env.GOOGLE_MAPS_API_KEY}`

export const generateGoogleApiUrl = (title: string, city: string) => {
    const refactoredTitle = title.replace(' ', '+')
    const refactoredCity = title.replace(' ', '+')
    return GOOGLE_API_URL.replace('{title}', refactoredTitle).replace('{city}', refactoredCity)
}
