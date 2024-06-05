import { model, Schema, Model, Types, Document } from 'mongoose';

export interface IToken extends Document {
	token: string;
	refreshToken: string;
	agent: string;
	time: Date;
	user: Types.ObjectId;
}

const tokenSchema = new Schema({
	token: {
		type: String,
		required: true,
	},
	refreshToken: {
		type: String,
		required: true,
	},
	agent: {
		type: String,
		required: true,
	},
	time: {
		type: Date,
		required: true,
		default: Date.now,
	},
	user: {
		type: Types.ObjectId,
		required: true,
		ref: 'User',
	},
});
const Token: Model<IToken> = model<IToken>('Tokens', tokenSchema);
export default Token;
