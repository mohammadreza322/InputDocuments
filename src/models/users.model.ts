import { Schema, model } from "mongoose";


const UserSchema = new Schema(
	{
		fullName: {
			type: String,
			// required:true
		},
		
		phoneNumber: {
			type: String,
			required: true,
			unique: true,
		},
		
		status: {
			type: String,
			default: 'not_enter',
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
	},
	{ toJSON: { virtuals: true } },
);

const  Users = model('User', UserSchema);
export default Users;
