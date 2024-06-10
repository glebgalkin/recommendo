import {searchUserRecommendations} from "../src/service/recommendo-service";
import {SearchRecommendationsRequest} from "../src/model/service/user-recommendation-request";
import {SourceType} from "../src/types/source-types";
import {UserRecommendation} from "../src/model/repository/user-recommendation";
import {InstagramInfo} from "../src/model/repository/social-table/instagram-info";
import {GoogleMapsInfo} from "../src/model/repository/social-table/google-maps-info";

const cityId1 = 'city_id_1';
const cityId2 = 'city_id_2';

const instId1 = 'inst_1';
const instId2 = 'inst_2';

const mapsId1 = 'google_maps_id_1';
const mapsId2 = 'google_maps_id_2';

describe('Test search recommendations', () => {


    it('test search', async () => {
        await prepareData();

        const request: SearchRecommendationsRequest = {
            offset: 0,
            limit: 10,
            cityId: cityId1,
            locale: 'en',
        };
        const emptyResult = await searchUserRecommendations(request);

        console.log(emptyResult);
    });


});

async function prepareData() {
    await prepareRecommendations();
    await prepareSocials();
}

async function prepareSocials() {
    await new InstagramInfo({
        _id: instId1,
        name: 'Instagram_1',
        originUrl: `url_${instId1}`,
        description: 'Super description',
        images: [],
        posts: 10,
        followerCount: 100,
        followingCount: 15,
    }).save();

    await new InstagramInfo({
        _id: instId2,
        name: 'Instagram_2',
        originUrl: `url_${instId2}`,
        description: 'Super description',
        images: [],
        posts: 123,
        followerCount: 11,
        followingCount: 33,
    }).save();

    await new GoogleMapsInfo({
        _id: mapsId1,
        name: 'Google Maps 1',
        originUrl: `url_${mapsId1}`,
        description: 'Super description',
        images: [],
        reviewsCount: 1234,
        googleMapsRating: 4.4,
    }).save();

    await new GoogleMapsInfo({
        _id: mapsId2,
        name: 'Google Maps 2',
        originUrl: `url_${mapsId2}`,
        description: 'Super description',
        images: [],
        reviewsCount: 22,
        googleMapsRating: 3.4,
    }).save();
}

async function prepareRecommendations() {
    for (let i = 0; i < 100; i++) {
        await generateRecommendation(SourceType.INSTAGRAM, instId1, i);
    }

    for (let i = 0; i < 50; i++) {
        await generateRecommendation(SourceType.INSTAGRAM, instId2, i);

    }

    for (let i = 0; i < 50; i++) {
        await generateRecommendation(SourceType.GOOGLE_API, mapsId1, i);

    }

    for (let i = 0; i < 10; i++) {
        await generateRecommendation(SourceType.GOOGLE_API, mapsId2, i);
    }
}

async function generateRecommendation(type: SourceType, id: string, i: number) {
    const userId = (id: number) => `user_id_${id}`;
    await new UserRecommendation({
        text: 'Some text',
        cityId: cityId1,
        userId: userId(i),
        socialId: id,
        socialType: type,
    }).save();
}