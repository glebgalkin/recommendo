export type GoogleApiPlaceIdSearchBody = {
    textQuery: string;
    locationBias?: LocationBias;
};

type LocationBias = {
    circle: {
        center: {
            latitude: number
            longitude: number
        }
        radius: number
    }
};