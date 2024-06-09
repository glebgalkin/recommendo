import {PlacesClient} from "@googlemaps/places";
import {FetchSocial} from "./social-service";
import {IGoogleMapsInfo} from "../../model/repository/social-table/google-maps-info";

const placesClient = new PlacesClient();

export const fetchGoogleMapsInfo: FetchSocial = async (googleId: string): Promise<IGoogleMapsInfo> => {
    const result = await placesClient.getPlace({name: googleId}).then(result => result[0]);
    const images = result.photos?.map(e => e.name).flatMap(e => e ? [e] : []) ?? [];
    return {
        id: googleId,
        name: result.name!,
        originUrl: result.googleMapsUri!,
        //description?: string;
        images: images,
        reviewsCount: result.reviews?.length ?? 0,
        googleMapsRating: result.rating ?? 0,
    };
}