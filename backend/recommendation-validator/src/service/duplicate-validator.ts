import {Db} from "mongodb";
import {Recommendation} from "../types/recommendation";

export const validateDuplicate = async (db: Db, recommendation: Recommendation) => {
    const collection = db.collection('recommendations');
    const query = { 'socials.instagram': recommendation.socials.instagram };
    const isDuplicate = await collection.findOne(query);
    if(isDuplicate){
        throw new Error('Duplicated post content submitted')
    }
}