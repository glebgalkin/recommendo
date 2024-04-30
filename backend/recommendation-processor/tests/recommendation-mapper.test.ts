import {describe, it, expect} from "vitest";
import {UserMeta} from "../src/types/user-meta";
import {FERecommendation, GoogleApi, Recommendation} from "../src/types/recommendation";
import {mapRecommendation} from "../src/mapper/recommendation-mapper";
import {GoggleApiPlaceInfo} from "../src/types/google-api/google-map-api";

describe('Recommendation mapper unit tests', () => {
    it('Should correctly map user meta and front-end recommendation to recommendation object', () => {
        const userMeta: UserMeta = {
            userId: '123',
            name: 'John Doe',
            email: 'john.doe@example.com'
        };

        const feRecommendation: FERecommendation = {
            title: 'Best place to buy coffee',
            description: 'Coffee shop',
            socials: {
                instagram: 'insta.com/coffee',
                facebook: 'facebook.com/coffee'
            },
            city: {
                name: 'Montreal',
                id: 'mtl-38937'
            }
        };

        const recommendation: Recommendation = mapRecommendation(userMeta, feRecommendation, null);

        expect(recommendation.userId).toBe(userMeta.userId);
        expect(recommendation.name).toBe(userMeta.name);
        expect(recommendation.email).toBe(userMeta.email);
        expect(recommendation.title).toBe(feRecommendation.title);
        expect(recommendation.description).toBe(feRecommendation.description);
        expect(recommendation.socials).toEqual(feRecommendation.socials);
        expect(recommendation.city).toEqual(feRecommendation.city);
    });

    it('Map the recommendation with provided google api info', () => {

        const userMeta: UserMeta = {
            userId: '456',
            name: 'Alex Morning',
            email: 'alex.morning@example.com'
        };

        const feRecommendation: FERecommendation = {
            title: 'Hotty Dogs',
            description: 'Best place to eat hot dogs',
            socials: {
                instagram: 'insta.com/hotty-dogs',
                facebook: 'facebook.com/hotty-dogs'
            },
            city: {
                name: 'Toronto',
                id: 'tor-19726'
            }
        };

        const googlePlaceInfo: GoggleApiPlaceInfo = {
            business_status: 'OPEN',
            formatted_address: '720 Rue Saint Jaques, Montreal, Quebec H3C 1A1, Canada',
            name: 'Hottest Dogs',
            rating: 4.7,
            types: ['restaurant', 'fast-food', 'street-food'],
            user_ratings_total: 23
        } as unknown as GoggleApiPlaceInfo

        const recommendation: Recommendation = mapRecommendation(userMeta, feRecommendation, googlePlaceInfo)

        expect(recommendation.userId).toBe('456')
        expect(recommendation.name).toBe('Alex Morning')
        expect(recommendation.email).toBe('alex.morning@example.com')
        expect(recommendation.title).toBe('Hotty Dogs')
        expect(recommendation.description).toBe('Best place to eat hot dogs')
        expect(recommendation.address?.street).toBe('720 Rue Saint Jaques')
        expect(recommendation.address?.city).toBe('Montreal')
        expect(recommendation.address?.province).toBe('Quebec')
        expect(recommendation.address?.postalCode).toBe('H3C 1A1')
        expect(recommendation.address?.providedBy).toBe('GOOGLE')
        expect(recommendation.socials.instagram).toBe('insta.com/hotty-dogs')
        expect(recommendation.socials.facebook).toBe('facebook.com/hotty-dogs')
        expect(recommendation.city.name).toBe('Toronto')
        expect(recommendation.city.id).toBe('tor-19726')
        expect(recommendation.googleApi?.businessStatus).toBe('OPEN')
        expect(recommendation.googleApi?.rating).toBe(4.7)
        expect(recommendation.googleApi?.tags).toEqual(['restaurant', 'fast-food', 'street-food'])
        expect(recommendation.googleApi?.userRatingsTotal).toBe(23)
        expect(recommendation.googleApi?.name).toBe('Hottest Dogs')
    })
});