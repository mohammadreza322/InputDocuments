import { Types } from 'mongoose';
import { Request } from 'express';
import { IUser } from '../models/users.model';
import {getUserFullInformationOutput} from "./user.type";
export interface CustomRequest extends Request {
	userDetails: IUser;
	userId: Types.ObjectId;
}

declare global {
	namespace Express {
		export interface Request {
			userDetails: IUser;
			userId: Types.ObjectId;
			user:getUserFullInformationOutput
		}
	}
}
