export interface ISocialTableBase {
    id: string;
    name: string;
    originUrl: string;
    description?: string;
    images: string[];
    createdAt?: Date;
    updatedAt?: Date;
}

export const socialTableBase = {
    id: {type: String, required: true, unique: true},
    name: {type: String, required: true},
    originUrl: {type: String, required: true},
    description: {type: String},
    images: {type: [String], default: []},
};