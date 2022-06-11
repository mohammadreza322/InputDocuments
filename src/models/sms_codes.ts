import mongoose,{Schema,Model} from "mongoose";

export interface IsmsCode {
  phoneNumber:string;
  code:string;
  date?:Date;
}


const smsCodesSchema:Schema = new Schema({
  phoneNumber:{
    type: "string",
    trim:true,
    required:true
  },
  code:{
    type:"string",
    trim:true,
    required:true
  },
  date:{
    type:Date,
    required:true,
    default:Date.now
  }
})


const SmsCode = mongoose.model('SmsCodes',smsCodesSchema);


export default SmsCode;
