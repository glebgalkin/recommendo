import {describe, it, vi, expect} from "vitest";
import {generateGoogleApiUrl} from "../src/constants/maps";
import {getAddressByGoogle, parseGoogleApiAddress} from "../src/service/address-parser";
import axios, {AxiosResponse} from "axios";
import {FERecommendation} from "../src/types/recommendation";

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

    it('test the address parser from google response', () => {
        const mockApiResponse = {
            data: {
                results: [{
                    formatted_address: '123 Coffee Lane, Beanville, CA'
                }]
            }
        };

        let result = parseGoogleApiAddress(mockApiResponse as unknown as AxiosResponse);
        expect(result).toBe('123 Coffee Lane, Beanville, CA');

        const emptyApiResponse = {
            data: {
                results: []
            }
        };

        result = parseGoogleApiAddress(emptyApiResponse as unknown as AxiosResponse);
        expect(result).toBeNull();
    })

    it('should call axios with the correct URL and return the address', async () => {
        vi.mock('axios');
        const mockApiResponse = {
            data: {
                results: [{
                    formatted_address: '123 Coffee Lane, Beanville, CA'
                }]
            }
        };
        vi.mocked(axios.get).mockResolvedValue(mockApiResponse);

        const feRecommendation = { title: 'Coffee Shop', city: { name: 'Beanville' } };
        const address = await getAddressByGoogle(feRecommendation as unknown as FERecommendation);

        expect(address).toBe('123 Coffee Lane, Beanville, CA');
    });

})