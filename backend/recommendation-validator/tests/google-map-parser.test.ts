import {describe, it, vi, expect} from "vitest";
import {generateGoogleApiUrl} from "../src/constants/maps";

describe('Google map api functionality unit tests', () => {

    it('Given recommendation title and city, generate google map api url', () => {
        vi.mock('process', () => {
            return {
                env: {
                    GOOGLE_MAPS_API_KEY: 'SOME_API_KEY'
                }
            };
        });

        it('Should correctly replace title and city in the URL template', () => {
            const title = '49th Parallel';
            const city = 'Montreal';

            const expectedUrl = `https://maps.googleapis.com/maps/api/place/textsearch/json?query=${title}+in+${city}&key=mocked_api_key`;
            const resultUrl = generateGoogleApiUrl(title, city);

            expect(resultUrl).toBe(expectedUrl);
        });
    })

})