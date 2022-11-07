import { Schema, model, Model, Document } from 'mongoose';

export interface IPermission extends Document {
	role: string;
	GET: Array<string>;
	POST: Array<string>;
	PUT: Array<string>;
	DELETE: Array<string>;
	initialRoute:string;
}

const permissionSchema = new Schema({
	role: {
		type: 'string',
		required: true,
		trim: true,
	},
	initialRoute:{
		type: 'string',
		default:'/'
	},
	GET: [
		{
			type: String,
		},
	],
	POST: [
		{
			type: String,
		},
	],
	PUT: [{ type: String }],
	DELETE: [{ type: String }],
});

const Permission: Model<IPermission> = model<IPermission>(
	'Permission',
	permissionSchema,
);

export default Permission;
