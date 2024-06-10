export interface ISocialTableBase {
    _id: string;
    name: string;
    originUrl: string;
    description?: string;
    images: string[];
    createdAt?: Date;
    updatedAt?: Date;
}

export const socialTableBase = {
    _id: {type: String, required: true},
    name: {type: String, required: true},
    originUrl: {type: String, required: true},
    description: {type: String},
    images: {type: [String], default: []},
};

export const defaultOptions = {
    timestamps: true,
    _id: false,
    versionKey: false
};