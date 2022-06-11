import { Request, Response } from 'express';
import {
	getMobileInput,
	checkOtpInput,
	checkOtpOutput,
} from '../types/login.type';
import isMobilePhone from 'validator/lib/isMobilePhone';
import LoginEntity from '../entities/login.entity';
import SmsProvider from '../classes/sms_provider';
import TokenEntity, { generateTokenOutput } from '../entities/token.entity';
import {
	accessTokenExpireTime,
	refreshTokenExpireTime,
} from '../utility/constants';

export const getMobile = async (req: Request, res: Response) => {
	const { phoneNumber }: getMobileInput = req.body;

	if (!phoneNumber) {
		return res
			.status(404)
			.json({ message: 'شماره تلفن خود را وارد کنید!' });
	}

	if (phoneNumber.trim() === '') {
		return res
			.status(404)
			.json({ message: 'شماره تلفن خود را وارد کنید!' });
	}

	if (!isMobilePhone(phoneNumber, 'fa-IR')) {
		return res
			.status(404)
			.json({ message: 'شماره تلفن وارد شده اشتباه است!' });
	}

	const loginOutput = await LoginEntity.getCode(phoneNumber);

	if (loginOutput?.id) {
		const smsProvider: SmsProvider = new SmsProvider(phoneNumber);

		console.log(
			await smsProvider.sendAuthSms(loginOutput.code!.toString()),
		);

		return res.json({
			message: 'پیامک با موفقیت ارسال شد',
			id: loginOutput.id,
			isNewUser: loginOutput.isNewUser,
		});
	}

	return res.status(400).json({ message: loginOutput?.message });
};

export const checkOtp = async (req: Request, res: Response) => {
	try {
		const { smsId, code, fullName }: checkOtpInput = req.body;

		const userAgent = req.get('user-agent');

		if (!userAgent) {
			return res.status(400).json({ message: 'ورودی نامعتبر!' });
		}

		if (!smsId || !code) {
			return res.status(404).json({ message: 'خطا در ورودی' });
		}

		if (smsId.trim() === '') {
			return res.status(404).json({ message: 'خطا در ورودی' });
		}

		if (code.trim() === '') {
			return res.status(404).json({ message: 'کد وارد شده اشتباه است' });
		}

		const otpDetails: checkOtpOutput = await LoginEntity.checkOtp(
			smsId,
			code,
			fullName,
		);

		if (otpDetails.message) {
			return res.status(404).json({ message: otpDetails.message });
		}

		const tokens: generateTokenOutput = await TokenEntity.createToken(
			otpDetails.userId!,
			userAgent,
		);

		return res.json({
			message: 'ورود موفقیت آمیز',
			accessToken: tokens.accessToken,

			accessTokenExpireTime,
			refreshTokenExpireTime,
			refreshToken: tokens.refreshToken,
		});
	} catch (error) {
		console.error('inside check otp');
		console.error(error);
		return res.status(500).json({ message: 'خطایی پیش آمده!!' });
	}
};