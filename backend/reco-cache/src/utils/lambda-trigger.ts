import {InvokeCommand, InvokeCommandOutput, LambdaClient} from "@aws-sdk/client-lambda";
import {LambdaTriggerType} from "../types/lambda-trigger-type";
export const triggerLambda = async (functionName: string, triggerType : LambdaTriggerType, functionPayload: any):Promise<InvokeCommandOutput> => {
    console.log('Triggering: ', functionName);
    const client = new LambdaClient({ region: 'ca-central-1' });
    const input = {
        FunctionName: functionName,
        InvocationType: triggerType,
        Payload: Buffer.from(JSON.stringify(functionPayload)),
    };
    const command = new InvokeCommand(input);
    return await client.send(command);
};