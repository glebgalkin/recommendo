import {SourceType} from "../src/types/source-types";
import {
    deleteUserRecommendation,
    getUserRecommendations,
    saveUserRecommendation,
    updateUserRecommendation
} from "../src/service/recommendo-service";
import {
    CreateUserRecommendationRequest, DeleteUserRecommendationRequest, GetUserRecommendationRequest,
    UpdateUserRecommendationRequest
} from "../src/model/service/user-recommendation-request";


describe('Test recommendation service', () => {
    const userId = 'user_id_1';
    it('save & update user recommendation', async () => {
        console.log('test reco 1');
        const request: CreateUserRecommendationRequest = {
            text: 'Text 1',
            cityId: 'city_id_1',
            userId: userId,
            source: {
                type: SourceType.GOOGLE_API,
                id: 'google_maps_id',
            }
        };
        const model = await saveUserRecommendation(request);
        expect(model._id).toBeDefined();
        expect(model.text).toBe('Text 1');
        expect(model.cityId).toBe('city_id_1');
        expect(model.userId).toBe(userId);
        expect(model.socialType).toBe('GOOGLE_API');
        expect(model.socialId).toBe('google_maps_id');

        request.text = 'Text 2';
        const model2 = await saveUserRecommendation(request);
        expect(model2._id).toStrictEqual(model._id);
        expect(model2.cityId).toBe('city_id_1');
        expect(model2.text).toBe('Text 1\nText 2');
        expect(model2.socialType).toBe('GOOGLE_API');
        expect(model2.socialId).toBe('google_maps_id');

        request.text = 'Text 3';
        request.cityId = 'city_id_2';
        const model3 = await saveUserRecommendation(request);
        expect(model3._id === model._id).toBeFalsy();
        expect(model3.text).toBe('Text 3');
        expect(model3.cityId).toBe('city_id_2');
        expect(model3.socialType).toBe('GOOGLE_API');
        expect(model3.socialId).toBe('google_maps_id');

        const updateRequest: UpdateUserRecommendationRequest = {
            id: model.id,
            userId: userId,
            text: 'Updated text',
        }
        const isUpdated = await updateUserRecommendation(updateRequest);
        expect(isUpdated).toBeTruthy();

        updateRequest.userId = 'user_id_2';
        const isUpdated2 = await updateUserRecommendation(updateRequest);
        expect(isUpdated2).toBeFalsy();
    });

    it('get & delete user recommendations', async () => {
        console.log('test reco 2');
        const request: GetUserRecommendationRequest = {
            userId: userId,
            offset: 0,
            limit: 10,
            locale: 'en',
        }
        const result = await getUserRecommendations(request);
        expect(result.length).toBe(2);

        request.offset = 1;
        const result2 = await getUserRecommendations(request);
        expect(result2.length).toBe(1);

        const deleteRequest: DeleteUserRecommendationRequest = {
            id: result[0].id,
            userId: 'wrong_user_id',
        }
        const isDeleted = await deleteUserRecommendation(deleteRequest);
        expect(isDeleted).toBeFalsy();

        deleteRequest.userId = userId;
        const isDeleted2 = await deleteUserRecommendation(deleteRequest);
        expect(isDeleted2).toBeTruthy();

        deleteRequest.id = result[1].id;
        const isDeleted3 = await deleteUserRecommendation(deleteRequest);
        expect(isDeleted3).toBeTruthy();

        const result3 = await getUserRecommendations(request);
        expect(result3.length).toBe(0);
    });
});
