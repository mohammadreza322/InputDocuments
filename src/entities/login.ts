import SmsCode from '../models/sms_codes'
import moment from 'moment'
import {getCodeOutput} from '../types/login';

export default class Login {
  static async getCode(phoneNumber:string) {
    const output: getCodeOutput  = {
      message:'',
      id:undefined,code:-1
    } 

    try {
    const smsCode = await SmsCode.findOne({phoneNumber}).sort({date:-1});

    if(smsCode) {
      const now = moment(new Date());
			const duration = moment
				.duration(now.diff(smsCode.date))
				.asMinutes();
			if (Math.floor(duration) < 2) {
        output.message = 'شما در 2 دقیقه گذشته یک بار درخواست داده اید'
				return output
			}
    }

    const code = this.generateCode();
    const newSmsCode = new SmsCode({phoneNumber,code})

    await newSmsCode.save();
    output.code = code;
    output.id = newSmsCode._id;

    return output }
    catch(e) {
      console.error('inside get code login');
      console.error(e);
      output.message='خطایی پیش آمده!'
    }
  }

  private static generateCode() {
    const min = 1000;
	const max = 9000;
	return Math.floor(min + Math.random() * max);
  }


}