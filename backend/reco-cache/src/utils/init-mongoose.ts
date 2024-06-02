import * as mongoose from "mongoose";

let conn: Promise<typeof mongoose> | null = null;

export const connectDB = async function(uri: string) {
    if (conn == null) {
        console.debug('connecting to mongo');
        conn = mongoose.connect(uri, {
            serverSelectionTimeoutMS: 5000
        }).then(() => mongoose);

        // `await`ing connection after assigning to the `conn` variable
        // to avoid multiple function calls creating new connections
        await conn;
    }

    return conn;
};