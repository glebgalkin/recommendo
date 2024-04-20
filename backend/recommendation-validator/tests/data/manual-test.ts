import {APIGatewayProxyEvent} from "aws-lambda";
import {lambdaHandler} from "../../src/app";

const body = {
    title: 'Best russian store',
    description: 'They have some great blinchiki',
    source: [{
        type: 'GOOGLE_API',
        id: 'ChIJlc1gav0ZyUwR57CU5laI_Pc',
    }],
    city: {
        name: 'Montreal',
        id: 'mtl-438'
    }
}

lambdaHandler({
    "requestContext": {
        "authorizer": {
            "jwt": {
                "claims": {
                    "aud": "recommendo-dev-er3r",
                    "auth_time": "1712805367",
                    "email": "alexey.chernyakov00@gmail.com",
                    "email_verified": "true",
                    "exp": "1713056995",
                    "firebase": "map[identities:map[email:[alexey.chernyakov00@gmail.com] google.com:[105135035507303880125]] sign_in_provider:google.com]",
                    "iat": "1713053395",
                    "iss": "https://securetoken.google.com/recommendo-dev-er3r",
                    "name": "Алексей Черняков",
                    "picture": "https://lh3.googleusercontent.com/a/ACg8ocJrDNelkgBbaTicuVG2WrHUoRcB0_3O8ku2KEJu1rEp_-TBIs2DKg=s96-c",
                    "sub": "gWNKr2oa2MaXRZ71YHp6Gm784wH2",
                    "user_id": "gWNKr2oa2MaXRZ71YHp6Gm784wH2"
                },
                "scopes": null
            }
        }
    },
    "body":  JSON.stringify(body)
} as unknown as APIGatewayProxyEvent);