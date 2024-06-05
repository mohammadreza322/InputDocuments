import {Types} from "mongoose";
import {IUser} from "../models/users.model";

export interface getFullNameInput {
	fullName: string;
}

export interface getUserInformationOutput {
	phoneNumber: string;
	fullName?: string;
	address?: string;
	birthday?: number;

}

export interface getUserFullInformationOutput extends getUserInformationOutput{
	role:string,
	id:Types.ObjectId;
	registerDate:Date
}

export interface editUserProfileInput {
	fullName: string;
	phoneNumber: string;
	address?: string;
	birthday?: number;
}

export interface lastCustomersOutput extends IUser{
	countDevices:number;
	jalaliRegisterDate:string;
	userJalaliBirthday:string
}
