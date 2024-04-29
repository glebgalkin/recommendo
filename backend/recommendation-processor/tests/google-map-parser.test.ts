import { describe, it, expect, beforeEach } from 'vitest';

// Mock the process.env before importing generateGoogleApiUrl
process.env.GOOGLE_MAPS_API_KEY = 'mock_api_key';

// Then import the function that uses process.env
import { generateGoogleApiUrl } from '../src/constants/google-api/url-constants';

describe('Google map api functionality unit tests', () => {
    beforeEach(() => {
        // Ensure the mock is in place before each test
        process.env.GOOGLE_MAPS_API_KEY = 'mock_api_key';
    });

    it('Given the placeId, generate google map api url', () => {
        const placeId = 'somePlaceId';
        const expectedUrl = `https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=mock_api_key`;
        const resultUrl = generateGoogleApiUrl(placeId);

        // Check that the result URL matches the expected URL
        expect(resultUrl).toBe(expectedUrl);
    });
});
