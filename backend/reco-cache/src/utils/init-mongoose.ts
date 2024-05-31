import * as mongoose from "mongoose";

let conn: Promise<typeof mongoose> | null = null;

const uri = process.env.MONGODB_CONNECTION_STRING!;

export const connectDB = async function() {
    if (conn == null) {
        conn = mongoose.connect(uri, {
            serverSelectionTimeoutMS: 5000
        }).then(() => mongoose);

        // `await`ing connection after assigning to the `conn` variable
        // to avoid multiple function calls creating new connections
        await conn;
    }

    return conn;
};