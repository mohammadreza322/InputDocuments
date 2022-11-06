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
import {isValidObjectId, Types} from "mongoose";

export const getFullName = async (req: CustomRequest, res: Response) => {
	try {
		const { fullName }: getFullNameInput = req.body;

		if (!fullName) {
			return res.status(400).json({ message: 'ورودی نامعتبر!' });
		}

		if (fullName.trim() === '') {
			return res.status(404).json({ message: 'خطا در ورودی' });
		}

		if(fullName.trim().length > 50){
			return res.status(404).json({ message: 'نام ورودی نمیتواند بیش از ۵۰ کاراکتر باشد' });
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
		const userDetails: getUserInformationOutput | null =
			await UserEntity.getUserInformation(req.userId);

		if(!userDetails) {
			return res.status(500).json({ message: 'خطایی پیش آمده!!' });
		}

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

		if(fullName.trim().length > 50){
			return res.status(404).json({ message: 'نام ورودی نمیتواند بیش از ۵۰ کاراکتر باشد' });
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

		if (address){
			if(address.trim().length > 200){
				return res.json({
					message: 'ادرس وارد شده نمیتواند بیشتر از ۲۰۰ کاراکتر باشد!',
				});
			}
		}

		if (
			await UserEntity.setUserDetails(
				req.userId,
				fullName,
				userBirthday,
				address,
			)
		) {
			const userDetails: getUserInformationOutput =
				await UserEntity.getUserInformation(req.userId);

			const userDevices: listOfDevices = await DeviceEntity.getAllDevices(
				req.userId,
			);

			return res.json({ message: 'اطلاعات شما با موفقیت تغییر کرد',user: userDetails, devices: userDevices });
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

	if (!refreshToken|| !userToken ) {
		return res.status(404).send({ message: 'خطا در شناسایی توکن' });
	}
	try {
		const decoded = jwt.decode(refreshToken, jsonWebTokenSecretKey);
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
		return res.json({ message: 'خطایی پیش آمده',hasError:true });
	}
};

export const addAdmin = async (req:Request,res:Response) => {
	try {
		const {fullName, phoneNumber, access, enable} = req.body

		const validateAdminOutput= validateAdmin(fullName,phoneNumber,access,enable);
		if(!validateAdminOutput.status){
			return res.status(400).json({message:validateAdminOutput.message,status:false})
		}
		if(await UserEntity.checkPhoneNumberExists(phoneNumber)){
			return res.status(400).json({status: false, message: 'شماره تماس وارد شده مربوط به کاربر دیگری میباشد'})
		}

		await UserEntity.addAdmin(fullName, phoneNumber, access, enable)

		return res.json({
			status: true,
			message: 'مدیر با موفقیت به سیستم اضافه شد',
		});
	} catch (e) {
		console.error('inside edit admin');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
}

export const editAdmin = async (req:Request,res:Response) => {
	try {
		const {fullName, phoneNumber, access, enable,id} = req.body

		if (!fullName || !phoneNumber || !access || !enable || !id) {
			return res.status(400).json({message: 'ورودی نامعتبر!'});
		}

		if(!isValidObjectId(id)){
			return res.status(400).json({message: 'ورودی نامعتبر!'});
		}

		const validateAdminOutput= validateAdmin(fullName,phoneNumber,access,enable);
		if(!validateAdminOutput.status){
			return res.status(400).json({message:validateAdminOutput.message,status:false})
		}

		if(await UserEntity.checkPhoneNumberWithId(new Types.ObjectId(id),phoneNumber)){
			return res.json({status: false, message: 'شماره تماس وارد شده مربوط به کاربر دیگری میباشد'})
		}

		await UserEntity.editAdmin(new Types.ObjectId(id),fullName, phoneNumber, access, enable)

		return res.json({
			status: true,
			message: 'اطلاعات مدیر با موفقیت تغییر کرد',
		});
	} catch (e) {
		console.error('inside add admin');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
}

const validateAdmin = (fullName:string,phoneNumber:string,access:string,enable:string) => {

	if (fullName.toString().trim() == '') {
		return {status:false,message: 'نام و نام خانوادگی را وارد نکرده اید!'};
	}

	if (phoneNumber.toString().trim() == '') {
		return {message: 'شماره تماس را وارد نکرده اید!',status:false};
	}

	if (access.toString().trim() == '') {
		return {message: 'سطح دسترسی را وارد نکرده اید!',status:false};
	}

	if (enable.toString().trim() == '') {
		return {status:false,message: 'وضعیت حساب را وارد نکرده اید!'};
	}

	if (!['admin', 'warehouse', 'customer_service'].includes(access)) {
		return {status:false,message: 'سطح دسترسی را وارد شده اشتباه است!'};
	}

	if (!['enable', 'disable'].includes(enable)) {
		return {status:false,message: 'وضعیت حساب وارد شده اشتباه است!'};
	}

	return {status:true,message:''}
}

export const deleteAdmin = async (req:Request,res:Response) => {
	try {
		const {id} = req.body;
		if (!id) {
			return res.status(400).json({message: 'ورودی نامعتبر!'});
		}

		if (id.toString().trim() == '') {
			return res.status(400).json({message: 'ورودی نامعتبر!'});
		}

		if (!isValidObjectId(id)) {
			return res.status(400).json({message: 'ورودی نامعتبر!'});
		}

		await UserEntity.deleteAdmin(new Types.ObjectId(id))

		return res.json({
			status: true,
			message: 'اطلاعات مدیر با موفقیت حذف شد',
		});

	}catch (e) {
		console.error('inside delete admin');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
}

export const editCurrentAdmin = async (req:Request,res:Response) => {
	try {
		const {fullName, phoneNumber} = req.body;

		if (!fullName || !phoneNumber) {
			return res.status(400).json({message: 'ورودی نامعتبر!'});
		}

		if (fullName.toString().trim() == '') {
			return {status: false, message: 'نام و نام خانوادگی را وارد نکرده اید!'};
		}

		if (phoneNumber.toString().trim() == '') {
			return {message: 'شماره تماس را وارد نکرده اید!', status: false};
		}

		if (await UserEntity.checkPhoneNumberWithId(new Types.ObjectId(req.user.id), phoneNumber)) {
			return res.json({status: false, message: 'شماره تماس وارد شده مربوط به کاربر دیگری میباشد'})
		}

		await UserEntity.editCurrentAdmin(new Types.ObjectId(req.user.id), fullName, phoneNumber)

		return res.json({
			status: true,
			message: 'اطلاعات مدیر با موفقیت تغییر کرد',
		});
	} catch (e) {
		console.error('inside add admin');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
}