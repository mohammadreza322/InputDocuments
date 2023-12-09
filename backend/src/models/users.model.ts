import { Schema, model, Document, Model, Types } from 'mongoose';

export interface IUser extends Document {
	_id?: Types.ObjectId;
	fullName?: string;
	phoneNumber: string;
	registerDate: Date;
	role: string;
	usernameBroker?: string;
	passwordBroker?: string;
	address?: string;
	birthday?: Date;
	enable:boolean;
}

const UserSchema = new Schema(
	{
		fullName: {
			type: String,
		},
		phoneNumber: {
			type: String,
			required: true,
			unique: true,
		},
		registerDate: {
			type: Date,
			default: Date.now,
		},
		role: {
			type: String,
			default: 'user',
		},
		usernameBroker: {
			type: String,
		},
		passwordBroker: {
			type: String,
		},
		address: {
			type: String,
		},
		birthday: {
			type: Date,
		},
		enable:{
			type:Boolean,
			default:true
		}
	},
	{ toJSON: { virtuals: true } },
);

const Users: Model<IUser> = model<IUser>('User', UserSchema);
export default Users;
