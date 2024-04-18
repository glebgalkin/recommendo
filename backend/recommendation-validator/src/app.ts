import {sendErrorResponse, sendSuccessfulResponse} from "./utils/responses";
import { APIGatewayProxyEvent } from 'aws-lambda';
import {processInput} from "./service/input-processor";
import {MongoClient, UpdateResult, Document} from "mongodb";
import {SourceType} from "./constants/source-types";

const client: MongoClient = new MongoClient(process.env.MONGODB_CONNECTION_STRING!);

export const lambdaHandler = async (event: APIGatewayProxyEvent) => {
    try{
        const result: UpdateResult<Document> = await processInput(event, client)
        return sendSuccessfulResponse(result)
    } catch (exception){
        return sendErrorResponse(exception)
    }
}

// // Dummy test object for Recommendation
// const dummyRecommendation = {
//     userId: "user123",
//     name: "Jane Doe",
//     email: "jane.doe@example.com",
//     title: "Top Rated Local Cafe - Parralel 49",
//     description: "Very nice friendly cafe. Very good latte",
//     source: {
//         type: SourceType.GOOGLE_API,
//         id: "ChIJlc1gav0ZyUwR57CU5laI_Pc"
//     },
//     address: {
//         apartmentUnit: "Apt 101",
//         street: "123 Coffee St",
//         city: "Coffeeville",
//         province: "CA",
//         postalCode: "12345",
//         providedBy: "Google Maps"
//     },
//     city: {
//         name: "Coffeeville",
//         id: "city456"
//     },
//     googleApi: {
//         businessStatus: "OPERATIONAL",
//         rating: 4.5,
//         tags: ["cafe", "coffee", "wifi"],
//         userRatingsTotal: 150,
//         name: "Cafe Central"
//     }
// };
//
// // Convert the dummyRecommendation object to a JSON string for the body
// const recommendationJSON = JSON.stringify(dummyRecommendation);
//
// lambdaHandler({
//     "requestContext": {
//         "authorizer": {
//             "jwt": {
//                 "claims": {
//                     "aud": "recommendo-dev-er3r",
//                     "auth_time": "1712805367",
//                     "email": "alexey.chernyakov00@gmail.com",
//                     "email_verified": "true",
//                     "exp": "1713056995",
//                     "firebase": "map[identities:map[email:[alexey.chernyakov00@gmail.com] google.com:[105135035507303880125]] sign_in_provider:google.com]",
//                     "iat": "1713053395",
//                     "iss": "https://securetoken.google.com/recommendo-dev-er3r",
//                     "name": "Алексей Черняков",
//                     "picture": "https://lh3.googleusercontent.com/a/ACg8ocJrDNelkgBbaTicuVG2WrHUoRcB0_3O8ku2KEJu1rEp_-TBIs2DKg=s96-c",
//                     "sub": "gWNKr2oa2MaXRZ71YHp6Gm784wH2",
//                     "user_id": "gWNKr2oa2MaXRZ71YHp6Gm784wH2"
//                 },
//                 "scopes": null
//             }
//         }
//     },
//     "body": recommendationJSON // Adding the serialized Recommendation object to the body
// } as unknown as APIGatewayProxyEvent);
