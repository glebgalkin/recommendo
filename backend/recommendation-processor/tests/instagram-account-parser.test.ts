import {describe, expect, it, vi} from "vitest";
import {SourceType} from "../src/constants/source-types";
import {processInstaRecommendation} from "../src/service/instagram-api/instagram-scrapper";
import axios from "axios";
import {readFileSync} from "fs";
import {InstagramApi, Source} from "../src/types/recommendation";

describe('Instagram parser unit test', () => {

    it('Given html, parse the followers, posts, following fields properly', async () => {

        const data = readFileSync('./tests/data/instagram-data-user.html', 'utf8');

        axios.get = vi.fn().mockResolvedValue({
            data: data
        });

        const mockSource = {
            id: 'someId-name',
            type: SourceType.INSTAGRAM
        }

        const result = await processInstaRecommendation(mockSource)
        expect(result?.id).toBe('someId-name')
        expect(result?.type).toBe('INSTAGRAM')

        const instagramExtra = result?.extra as InstagramApi
        expect(instagramExtra.followers).toBe('147M')
        expect(instagramExtra.following).toBe('3,338')
        expect(instagramExtra.posts).toBe('490')

    })
})