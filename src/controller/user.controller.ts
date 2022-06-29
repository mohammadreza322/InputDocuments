import { getFullNameInput } from '../types/user.type';
import { Response } from 'express';
import UserEntity from '../entities/user.entity';
import { CustomRequest } from '../types/global.type';

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
