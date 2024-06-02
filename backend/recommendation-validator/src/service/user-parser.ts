import {APIGatewayProxyEvent} from "aws-lambda";
import {UserMeta} from "@reco-cache/cache/types/user-meta"

export const parseUserMeta = (event: APIGatewayProxyEvent): UserMeta => {
    const claims = event.requestContext.authorizer!.jwt.claims
    return {
        email: claims.email,
        userId: claims.user_id
    }
}