import SmsCode from '../models/sms_codes';
import moment from 'moment';
import { getCodeOutput, checkOtpOutput } from '../types/login.type';
import Users from '../models/users.model';

export default class LoginEntity {
	static async getCode(phoneNumber: string) {
		const output: getCodeOutput = {
			message: '',
			id: undefined,
			code: -1,
			isNewUser: false,
		};

		try {
			const smsCode = await SmsCode.findOne({ phoneNumber }).sort({
				date: -1,
			});

			if (smsCode) {
				const now = moment(new Date());
				const duration = moment
					.duration(now.diff(smsCode.date))
					.asMinutes();
				if (Math.floor(duration) < 2) {
					output.message =
						'شما در 2 دقیقه گذشته یک بار درخواست داده اید';
					return output;
				}
			}

			const code = this.generateCode();
			const newSmsCode = new SmsCode({ phoneNumber, code });

			await newSmsCode.save();

			const userDetails = await Users.findOne({
				phoneNumber: newSmsCode.phoneNumber,
			});

			if (userDetails) {
				output.isNewUser = true;
			}

			output.code = code;
			output.id = newSmsCode._id;

			return output;
		} catch (e) {
			console.error('inside get code login');
			console.error(e);
			output.message = 'خطایی پیش آمده!';
		}
	}

	private static generateCode() {
		const min = 1000;
		const max = 9000;
		return Math.floor(min + Math.random() * max);
	}

	static async checkOtp(smsId: string, code: string, fullName?: string) {
		const smsCode = await SmsCode.findById(smsId);
		const output: checkOtpOutput = {};
		if (!smsCode) {
			output.message = 'کاربر مورد نظر یافت نشد!';
			return output;
		}

		if (smsCode.code !== code) {
			output.message = 'کد وارد شده اشتباه است!';
			return output;
		}

		const now = moment(new Date());
		const duration = moment
			.duration(now.diff(smsCode.lastAttempt))
			.asMinutes();

		if (duration > 2) {
			output.message = 'کد شما منقضی شده است لطفا دوباره درخواست بدهید!';
			return output;
		}

		const userDetails = await Users.findOne({
			phoneNumber: smsCode.phoneNumber,
		});

		let userId = null;

		if (!userDetails) {
			const user = new Users({
				phoneNumber: smsCode.phoneNumber,
			});
			await user.save();
			userId = user._id;
		} else {
			userId = userDetails._id;
		}

		await SmsCode.findByIdAndDelete(smsCode._id);

		output.userId = userId;

		return output;
	}
}
