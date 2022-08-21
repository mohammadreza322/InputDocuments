import {
	editUserProfileInput,
	getFullNameInput,
	getUserInformationOutput,
} from '../types/user.type';
import { Response, Request } from 'express';
import UserEntity from '../entities/user.entity';
import { CustomRequest } from '../types/global.type';
import { listOfDevices } from '../types/device.type';
import DeviceEntity from '../entities/device.entity';
import AhpValidator from '../classes/validator';
import { jsonWebTokenSecretKey } from '../utility/constants';
const jwt = require('jsonwebtoken');
import Token, { IToken } from '../models/tokens.model';
import moment from 'moment';
import TokenEntity, { generateTokenOutput } from '../entities/token.entity';

export const getFullName = async (req: CustomRequest, res: Response) => {
	try {
		const { fullName }: getFullNameInput = req.body;

		if (!fullName) {
			return res.status(400).json({ message: 'ورودی نامعتبر!' });
		}

		if (fullName.trim() === '') {
			return res.status(404).json({ message: 'خطا در ورودی' });
		}

		if (
			await UserEntity.setUserDetails(
				req.userId,
				fullName,
				undefined,
				undefined,
			)
		) {
			return res.json({ message: 'نام شما با موفقیت ثبت شد' });
		} else {
			return res.status(500).json({ message: 'خطایی پیش آمده!!' });
		}
	} catch (error) {
		console.error('inside get fullName');
		console.error(error);
		return res.status(500).json({ message: 'خطایی پیش آمده!!' });
	}
};

export const getUserDetails = async (req: CustomRequest, res: Response) => {
	try {
		const userDetails: getUserInformationOutput =
			await UserEntity.getUserInformation(req.userId);

		const userDevices: listOfDevices = await DeviceEntity.getAllDevices(
			req.userId,
		);

		return res.json({ user: userDetails, devices: userDevices });
	} catch (error) {
		console.error('inside get use details');
		console.error(error);
		return res.status(500).json({ message: 'خطایی پیش آمده!!' });
	}
};

export const editUserProfile = async (req: CustomRequest, res: Response) => {
	try {
		const { fullName, address, birthday }: editUserProfileInput = req.body;

		if (!fullName) {
			return res.json({ message: 'خطا در ورودی' });
		}

		if (fullName.trim() === '') {
			return res.json({ message: 'نام خود را وارد نکرده اید!' });
		}

		let userBirthday = undefined;

		if (birthday) {
			if (!AhpValidator.isValidDate(birthday)) {
				return res.json({
					message: 'تاریخ تولد وارد شده درست نیست!',
				});
			}

			userBirthday = new Date(birthday);
		}

		if (
			await UserEntity.setUserDetails(
				req.userId,
				fullName,
				userBirthday,
				address,
			)
		) {
			return res.json({ message: 'اطلاعات شما با موفقیت تغییر کرد' });
		} else {
			return res.status(500).json({ message: 'خطایی پیش آمده!!' });
		}
	} catch (error) {
		console.error('inside edit profile');
		console.error(error);
		return res.status(500).json({ message: 'خطایی پیش آمده!!' });
	}
};

export const refreshToken = async (req: CustomRequest, res: Response) => {
	const { refreshToken } = req.body;
	const userToken = req.header('x-auth-token');
	const userAgent = req.get('user-agent');

	if (!refreshToken || !userToken) {
		return res.status(404).send({ message: 'خطا در شناسایی توکن' });
	}

	if (refreshToken == null || userToken == null) {
		return res.status(404).send({ message: 'خطا در شناسایی توکن' });
	}
	try {
		const decoded = jwt.verify(refreshToken, jsonWebTokenSecretKey);
		const token = await Token.findOne({ token: userToken });
		if (!token) {
			return res.status(404).json({ message: 'invalid token1' });
		}

		if (refreshToken !== token.refreshToken) {
			return res.status(404).json({ message: 'invalid token2' });
		}

		if (!token.user.equals(decoded.id)) {
			return res.status(401).json({ message: 'Token is not valid' });
		}

		const now = moment(new Date());
		const duration = moment.duration(now.diff(token.time)).asDays();
		if (Math.floor(duration) > 30) {
			return res.status(404).json({ message: 'invalid refresh token!' });
		}

		await TokenEntity.removeOldToken(decoded.id, userAgent);

		const tokens: generateTokenOutput = await TokenEntity.createToken(
			decoded.id,
			userAgent,
		);
		return res.json({
			message: 'توکن شما با موفیت تغییر کرد',
			accessToken: tokens.accessToken,
			refreshToken: tokens.refreshToken,
		});
	} catch (e) {
		console.error('inside refresh token');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
};
