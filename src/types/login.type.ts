import { ObjectId, Types } from 'mongoose';
export interface getMobileInput {
	phoneNumber?: string;
}

export interface getCodeOutput {
	message: string;
	id?: ObjectId;
	code?: number;
	isNewUser: Boolean;
}

export interface checkOtpInput {
	smsId: string;
	code: string;
	isDashboard?:boolean
}

export interface checkOtpOutput {
	message?: string;
	userId?: Types.ObjectId;
}
