import { getFullNameInput, getUserInformationOutput } from '../types/user.type';
import { Response, Request } from 'express';
import UserEntity from '../entities/user.entity';
import { CustomRequest } from '../types/global.type';
import { listOfDevices } from '../types/device.type';
import DeviceEntity from '../entities/device.entity';

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
	const userDetails: getUserInformationOutput =
		await UserEntity.getUserInformation(req.userId);

	const userDevices: listOfDevices = await DeviceEntity.getAllDevices(
		req.userId,
	);

	return res.json({ user: userDetails, devices: userDevices });
};
