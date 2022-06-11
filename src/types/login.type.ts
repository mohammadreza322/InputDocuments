
import {ObjectId} from 'mongoose'
export interface getMobileInput {
  phoneNumber?:string;
}

export interface getCodeOutput {
  message:string;
  id?:ObjectId;
  code?:number,
  isNewUser:Boolean
}

export interface checkOtpInput {
  smsId:string;
  code:string;
  fullName?:string
}

export interface checkOtpOutput {
  message?:string;
  userId?:string
}