export enum SourceType {
    GOOGLE_API = 'GOOGLE_API',
    INSTAGRAM = 'INSTAGRAM',
    FACEBOOK = 'FACEBOOK',
}

export const typeToProperty = (type: SourceType): string => {
    switch (type) {
        case SourceType.GOOGLE_API: return "googleMapsId";
        case SourceType.INSTAGRAM: return "instagramId";
        case SourceType.FACEBOOK: return "facebookId";
    }
}