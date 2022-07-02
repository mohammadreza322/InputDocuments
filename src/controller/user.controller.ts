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
