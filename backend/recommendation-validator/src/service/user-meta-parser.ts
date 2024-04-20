import {APIGatewayProxyEvent} from "aws-lambda";
import {UserMeta} from "../types/user-meta";

export const parseUserMeta = (event: APIGatewayProxyEvent): UserMeta => {
    const claims = event.requestContext.authorizer!.jwt.claims
    return {
        email: claims.email,
        userId: claims.user_id
    }
}