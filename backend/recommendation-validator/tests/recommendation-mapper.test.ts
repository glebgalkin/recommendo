import {describe, it, expect} from "vitest";
import {UserMeta} from "../src/types/user-meta";
import {FERecommendation, Recommendation} from "../src/types/recommendation";
import {mapRecommendation} from "../src/service/recommendation-mapper";

describe('Recommendation mapper unit tests', () => {
    it('Should correctly map user meta and front-end recommendation to recommendation object', () => {
        const userMeta: UserMeta = {
            user_id: '123',
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

        expect(recommendation.userId).toBe(userMeta.user_id);
        expect(recommendation.name).toBe(userMeta.name);
        expect(recommendation.email).toBe(userMeta.email);
        expect(recommendation.title).toBe(feRecommendation.title);
        expect(recommendation.description).toBe(feRecommendation.description);
        expect(recommendation.socials).toEqual(feRecommendation.socials);
        expect(recommendation.city).toEqual(feRecommendation.city);
    });
});