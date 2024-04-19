import {describe, expect, it} from "vitest";
import {UserMeta} from "../src/types/user-meta";
import {parseUserMeta} from "../src/service/user-meta-parser";

describe('User meta parser test', () => {

    it('Given event, parse user meta', () => {
        const feRecommendationRequest = require('./data/new-recommendation-event.json')
        const userMeta: UserMeta = parseUserMeta(feRecommendationRequest)

        expect(userMeta.userId).toBe('gWNKr2oa2MaXRZ71YHp6Gm784wH21')
        expect(userMeta.name).toBe('Alex Jones')
        expect(userMeta.email).toBe('some-email@gmail.com')
    })
})