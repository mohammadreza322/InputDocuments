import mongoose, { Schema, Model, Document } from 'mongoose';

export interface ISmsCode extends Document {
	phoneNumber: string;
	code: string;
	date?: Date;
}

const smsCodesSchema: Schema = new Schema({
	phoneNumber: {
		type: 'string',
		trim: true,
		required: true,
	},
	code: {
		type: 'string',
		trim: true,
		required: true,
	},
	date: {
		type: Date,
		required: true,
		default: Date.now,
	},
});

const SmsCode: Model<ISmsCode> = mongoose.model<ISmsCode>(
	'SmsCodes',
	smsCodesSchema,
);

export default SmsCode;
