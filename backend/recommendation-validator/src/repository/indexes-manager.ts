import {MongoClient} from "mongodb";

export const createIndexes = async () => {
    const client = new MongoClient(process.env.MONGODB_CONNECTION_STRING!);

    try{
        await client.connect()
        const db = client.db('recommendo')
        const collection = db.collection('recommendations')

        const instaIndex = await collection.createIndex({ 'socials.instagram': 1 });
        const userIdInstaIndex = await collection.createIndex({ 'userId': 1, 'socials.instagram': 1 });
        // await collection.dropIndex('socials.instagram_1');
        console.log('Index created:', instaIndex);
        console.log('Index created:', userIdInstaIndex);
    } catch (err) {
        console.error('Failed to create indexes:', err);
    } finally {
        await client.close();
    }
}

createIndexes()