
import {ObjectId} from 'mongoose'
export interface getMobileInput {
  phoneNumber?:string;
}

export interface getCodeOutput {
  message:string;
  id?:ObjectId;
  code?:number
}