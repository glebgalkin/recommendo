// import {describe, expect, it} from "vitest";
// import {validateRecommendation} from "../src/service/recommendation-validator";
// import {FERecommendation} from "../src/types/recommendation";
// import {APIGatewayProxyEvent} from "aws-lambda";
//
// describe('Recommendation validation unit tests', () => {
//
//     it('Given recommendation, validate the content', () => {
//         const feRecommendationRequest = require('./data/new-recommendation-event.json')
//         const recommendation: FERecommendation = validateRecommendation(feRecommendationRequest);
//
//         expect(recommendation.title).toBe('Best place to buy coffee')
//         expect(recommendation.description).toBe('Coffee shop')
//         expect(recommendation.socials.instagram).toBe('insta.com/crack')
//         expect(recommendation.city.id).toBe('mtl-38937')
//         expect(recommendation.city.name).toBe('Montreal')
//     })
//
//     it('Should throw an error when the title is missing', () => {
//         const feRecommendationRequest = {
//             body: JSON.stringify({
//                 description: 'Coffee shop',
//                 socials: {
//                     instagram: 'insta.com/crack'
//                 },
//                 city: {
//                     name: 'Montreal',
//                     id: 'mtl-38937'
//                 }
//             })
//         } as unknown as APIGatewayProxyEvent;
//
//         expect(() => validateRecommendation(feRecommendationRequest)).toThrow('No recommendation title provided');
//     });
//
//     it('Should throw an error when the instagram URL is missing', () => {
//         const eventMissingInstagram: APIGatewayProxyEvent = {
//             body: JSON.stringify({
//                 title: 'Best place to buy coffee',
//                 description: 'Coffee shop',
//                 socials: {
//                     facebook: 'facebook.com/coffee',
//                     twitter: 'twitter.com/coffee'
//                 },
//                 city: {
//                     name: 'Montreal',
//                     id: 'mtl-38937'
//                 }
//             }),
//         } as unknown as APIGatewayProxyEvent;
//
//         expect(() => validateRecommendation(eventMissingInstagram)).toThrow('No instagram url provided');
//     });
//
//     it('Should throw an error when the city name is missing', () => {
//         const eventMissingCityName: APIGatewayProxyEvent = {
//             body: JSON.stringify({
//                 title: 'Best place to buy coffee',
//                 description: 'Coffee shop',
//                 socials: {
//                     instagram: 'insta.com/crack',
//                     facebook: 'facebook.com/crack',
//                 },
//                 city: {
//                     id: 'mtl-38937'
//                 }
//             }),
//         } as unknown as APIGatewayProxyEvent;
//
//         expect(() => validateRecommendation(eventMissingCityName)).toThrow('No city name is provided');
//     });
//
//     it('Should throw an error when the city id is missing', () => {
//         const eventMissingCityId: APIGatewayProxyEvent = {
//             body: JSON.stringify({
//                 title: 'Best place to buy coffee',
//                 description: 'Coffee shop',
//                 socials: {
//                     instagram: 'insta.com/crack',
//                     facebook: 'facebook.com/crack',
//                 },
//                 city: {
//                     name: 'Montreal',
//                 }
//             }),
//         } as unknown as APIGatewayProxyEvent;
//
//
//         expect(() => validateRecommendation(eventMissingCityId)).toThrow('No city id is provided');
//     });
// })