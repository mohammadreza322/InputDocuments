import {Request,Response} from 'express'
import {getMobileInput} from '../types/login'
import isMobilePhone from 'validator/lib/isMobilePhone';
import Login from '../entities/login'
import SmsProvider from '../classes/sms_provider';


export const getMobile = async (req:Request,res:Response) => {

  const {phoneNumber}:  getMobileInput = req.body;

  if(!phoneNumber) {
    return res.status(404).json({message:'شماره تلفن خود را وارد کنید!'})
  }

  if(phoneNumber.trim()===''){
    return res.status(404).json({message:'شماره تلفن خود را وارد کنید!'})
  }

  if(!isMobilePhone(phoneNumber,'fa-IR')){
    return res.status(404).json({message:'شماره تلفن وارد شده اشتباه است!'});
  }

  const loginOutput = await Login.getCode(phoneNumber);

  if(loginOutput?.id) {
    const smsProvider:SmsProvider = new SmsProvider(phoneNumber);
    smsProvider.sendAuthSms(loginOutput.code!.toString())

    return res.json({message:'پیامک با موفقیت ارسال شد',code:loginOutput.id});
  }

  return res.status(400).json({message:loginOutput?.message});

}