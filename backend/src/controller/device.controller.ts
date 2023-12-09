import {Request, Response} from 'express';
import { isValidObjectId, ObjectId, Types } from 'mongoose';
import AhpValidator from '../classes/validator';
import DeviceEntity from '../entities/device.entity';
import {
	addDeviceInput,
	saveScheduleInput,
	deleteDeviceInput,
	listOfDevices,
} from '../types/device.type';
import { CustomRequest } from '../types/global.type';
import BrokerProvider from "../classes/broker_provider";
import LogsEntity from "../entities/logs.entity";

export const saveDevice = async (req: CustomRequest, res: Response) => {
	try {
		const { serialNumber, name, category }: addDeviceInput = req.body;

		if (!serialNumber || !name || !category) {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (serialNumber.trim() === '') {
			return res
				.status(400)
				.json({ message: 'شماره سریال را وارد نکرده اید!' });
		}

		if (category.trim() === '') {
			return res
				.status(400)
				.json({ message: 'دسته بندی را وارد نکرده اید!' });
		}

		if (name.trim() === '') {
			return res
				.status(400)
				.json({ message: 'نام دستگاه را وارد نکرده اید!' });

		}

		if (name.trim().length > 50) {
			return res
				.status(400)
				.json({ message: 'نام دستگاه نمیتواند بیشتر از ۵۰ کاراکتر باشد!' });
		}

		if (category.trim().length > 50) {
			return res
				.status(400)
				.json({ message: 'دسته بندی دستگاه نمیتواند بیشتر از ۵۰ کاراکتر باشد!' });
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumber(
			serialNumber.trim(),
			req.userId,
			'save',
		);

		if (!validateSerialNumber.valid) {
			return res
				.status(400)
				.json({ message: validateSerialNumber.message });
		}

		if (validateSerialNumber.type == 'cooler') {
			const { model }: addDeviceInput = req.body;

			if (!model) {
				return res.status(400).json({ message: 'مدل دستگاه را وارد نکرده اید!' });
			}

			// if (brand!.trim() === '') {
			// 	return res
			// 		.status(400)
			// 		.json({ message: 'برند کولر را وارد نکرده اید' });
			// }

			if (model!.trim() === '') {
				return res
					.status(400)
					.json({ message: 'مدل کولر را وارد نکرده اید!' });
			}

			if (model!.trim().length > 25) {
				return res
					.status(400)
					.json({ message: 'مدل کولر نمیتواند بیش تر از ۲۵ کاراکتر  باشد' });
			}

			//todo check validate brand and model

			await DeviceEntity.saveCooler(
				serialNumber.trim(),

				model!.trim(),
				name.trim(),
				category.trim(),
				req.userId,
			);
		} else if (validateSerialNumber.type == 'power') {
			let { power1, power2, power3, power4, usb1, usb2 }: addDeviceInput =
				req.body;

			// if (power1.toString().trim() == '') {
			// 	power1 = 'پریز 1';
			// }

			// if (power2.toString().trim() == '') {
			// 	power2 = 'پریز 2';
			// }

			// if (power3.toString().trim() == '') {
			// 	power3 = 'پریز 3';
			// }

			// if (power4.toString().trim() == '') {
			// 	power4 = 'پریز 4';
			// }

			// if (usb1.toString().trim() == '') {
			// 	usb1 = 'پورت 1';
			// }

			// if (usb2.toString().trim() == '') {
			// 	usb2 = 'پورت 1';
			// }

			await DeviceEntity.savePower(
				serialNumber.trim(),
				category.trim(),
				name.trim(),
				req.userId,
				power1,
				power2,
				power3,
				power4,
				usb1,
				usb2,
			);
		}

		const devices: listOfDevices = await DeviceEntity.getAllDevices(
			req.userId,
		);

		return res.json({ message: 'دستگاه شما با موفقیت ذخیره شد', devices });
	} catch (err) {
		console.error('inside add device');
		console.error(err);
		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
};

export const deleteDevice = async (req: CustomRequest, res: Response) => {
	try {
		const { serialNumber }: deleteDeviceInput = req.body;

		if (!serialNumber) {
			return res.status(400).json({ message: 'خطا در ورودی!' });
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumber(
			serialNumber,
			req.userId,
			'delete',
		);

		if (!validateSerialNumber.valid) {
			return res
				.status(400)
				.json({ message: validateSerialNumber.message });
		}

		await DeviceEntity.deleteOwnerDevice(
			serialNumber,
			validateSerialNumber.type,
		);

		const devices = await DeviceEntity.getAllDevices(req.userId);

		return res.json({ message: 'دستگاه شما با موفقیت حذف شد', devices });
	} catch (err) {
		console.error('inside delete device');
		console.error(err);

		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
};

export const saveSchedule = async (req: CustomRequest, res: Response) => {
	try {
		const {
			startTime,
			endTime,
			repeat,
			serialNumber,
			portNumber,
			id,
			enable,
		}: saveScheduleInput = req.body;

		if (!startTime && !endTime) {
			return res.status(400).json({ message: 'زمان روشن شدن یا زمان خاموش شدن باید انتخاب شود' });
		}

		if (!serialNumber || !repeat) {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (serialNumber.trim() === '') {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (!AhpValidator.isWeekDayArray(repeat)) {
			return res.status(400).json({ message: 'فرمت انتخاب روز های هفته اشتباه است' });
		}

		if (startTime) {
			if (!AhpValidator.isTime(startTime)) {
				return res.status(400).json({ message: 'فرمت ساعت روشن شدن اشتباه است' });
			}
		}

		if (endTime) {
			if (!AhpValidator.isTime(endTime)) {
				return res.status(400).json({ message: 'فرمت ساعت خاموش شدن اشتباه است' });
			}
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumber(
			serialNumber,
			req.userId,
			'addSchedule',
		);

		if (!validateSerialNumber.valid) {
			return res
				.status(500)
				.json({ message: validateSerialNumber.message });
		}

		if (validateSerialNumber.type === 'power') {
			if (!portNumber) {
				return res.status(400).json({ message: 'خطا در ورودی' });
			}
		}

		if (!id) {
			await DeviceEntity.addSchedule({
				serialNumber: serialNumber.trim(),
				startTime: startTime?.trim(),
				endTime: endTime?.trim(),
				repeat,
				type: validateSerialNumber.type,
				portNumber,
			});
		} else {
			if (enable === undefined || enable == null) {
				return res.status(400).json({ message: 'خطا در ورودی' });
			}

			if (typeof enable !== 'boolean') {
				return res.status(400).json({ message: 'خطا در ورودی' });
			}

			if (id.trim() === '') {
				return res.status(400).json({ message: 'خطا در ورودی' });
			}

			if (!isValidObjectId(id)) {
				return res.status(400).json({ message: 'خطا در ورودی' });
			}

			await DeviceEntity.editSchedule({
				serialNumber,
				startTime,
				endTime,
				repeat,
				portNumber,
				enable,
				_id: new Types.ObjectId(id),
				type: validateSerialNumber.type,
			});
		}

		const devices = await DeviceEntity.getAllDevices(req.userId);

		return res.json({
			message: 'تغییرات شما با موفقیت ذخیره شد',
			devices,
		});
	} catch (err) {
		console.error('inside add schedule');
		console.error(err);

		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
};

export const deleteSchedule = async (req: CustomRequest, res: Response) => {
	try {
		const { serialNumber, id }: deleteDeviceInput = req.body;

		if (!serialNumber || !id) {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (serialNumber.trim() === '') {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (id.trim() === '') {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumber(
			serialNumber,
			req.userId,
			'deleteSchedule',
		);

		if (!validateSerialNumber.valid) {
			return res
				.status(400)
				.json({ message: validateSerialNumber.message });
		}

		await DeviceEntity.deleteSchedule(
			serialNumber,
			new Types.ObjectId(id),
			validateSerialNumber.type,
		);

		const devices = await DeviceEntity.getAllDevices(req.userId);

		return res.json({
			message: 'تغییرات شما با موفقیت ذخیره شد',
			devices,
		});
	} catch (err) {
		console.error('inside delete schedule');
		console.error(err);

		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
};

export const deleteOwnerOfDevice = async (req: CustomRequest, res: Response) => {
	try {
		const { serialNumber }: deleteDeviceInput = req.body;

		if (!serialNumber) {
			return res.status(400).json({ message: 'خطا در ورودی!',status:false });
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumberForAdmin(
			serialNumber,
		);

		if (!validateSerialNumber.valid) {
			return res
				.status(400)
				.json({ message: validateSerialNumber.message ,status:false});
		}


		await DeviceEntity.deleteOwnerDevice(
			serialNumber,
			validateSerialNumber.type,
		);

		return res.json({ message: 'دستگاه شما با موفقیت حذف شد',status:true });
	} catch (err) {
		console.error('inside delete device site');
		console.error(err);

		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
};

export const kickDevice = async (req:Request,res:Response) => {
	try {
		const {serialNumber}= req.body;

		if (!serialNumber) {
			return res.status(400).json({message: 'خطا در ورودی!', status: false});
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumberForAdmin(
			serialNumber,
		);

		if (!validateSerialNumber.valid) {
			return res
				.status(400)
				.json({message: validateSerialNumber.message, status: false});
		}

		await BrokerProvider.kickDevice(serialNumber);

		await LogsEntity.kickDeviceFromBroker(serialNumber,req.user.id,req.user.fullName)

		return res
			.json({message: 'ارتباط دستگاه با موفقیت با سرور قطع شد', status: true});
	} catch (err) {
		console.error('inside kick device');
		console.error(err);

		return res.status(500).json({ message: 'خطایی پیش آمده',status:false });
	}
}

export const addDevice = async (req:Request,res:Response) => {
	try {
		const { password, type} = req.body
		let serialNumber = req.body.serialNumber

		if (!serialNumber || !password || !type) {
			return res.status(400).json({status:false,message: 'خطا در ورودی'});
		}

		if (serialNumber.toString().trim() == '') {
			return res.status(400).json({status:false,message: 'شماره سریال را وارد نکرده اید'});
		}

		if (password.toString().trim() == '') {
			return res.status(400).json({status:false,message: 'کلمه عبور دستگاه را وارد نکرده اید'});
		}

		if (type.toString().trim() == '') {
			return res.status(400).json({status:false,message: 'نوع دستگاه را وارد نکرده اید'});
		}

		if (!['cooler', 'power'].includes(type.toString())) {
			return res.status(400).json({status:false,message: 'خطا در ورودی'});
		}

		if(await DeviceEntity.deviceExists(serialNumber)){
			return res.status(400).json({status:false,message: 'این شماره سریال برای دستگاه دیگری قبلا ثبت شده است!'});

		}

		let deviceId = undefined

		if(type == 'power') {
			serialNumber = `chp-${serialNumber}`;
			deviceId = await DeviceEntity.addPower(serialNumber, password, req.user.id)
			await LogsEntity.addDevicePower(serialNumber,req.user.id,deviceId)
		} else if (type=='cooler') {
			serialNumber = `chc-${serialNumber}`;
			deviceId = await DeviceEntity.addCooler(serialNumber,password,req.user.id)
			await LogsEntity.addDeviceCooler(serialNumber,req.user.id,deviceId)
		}

		await BrokerProvider.addUserToMnesia(serialNumber,password);

		

		return res.json({status:true,message:'دستگاه با موفقیت اضافه شد!'})

	}catch (err) {
		console.error('inside add device');
		console.error(err);

		return res.status(500).json({ message: 'خطایی پیش آمده',status:false });
	}
}

export const deleteDeviceInStoreRoom = async (req:Request,res:Response) => {
	try {
		const {serialNumber, type} = req.body

		if (!serialNumber || !type) {
			return res.status(400).json({status:false,message: 'ورودی نامعتبر!'});
		}

		if (serialNumber.toString().trim() == '') {
			return res.status(400).json({status:false,message: 'ورودی نامعتبر!'});
		}

		if (type.toString().trim() == '') {
			return res.status(400).json({status:false,message: 'ورودی نامعتبر!'});
		}

		if (type == 'cooler') {
			if (!await DeviceEntity.coolerExists(serialNumber)) {
				return res.status(400).json({status:false,message: 'ورودی نامعتبر!'});
			}

			await DeviceEntity.removeCooler(serialNumber)
		} else if (type == 'power') {
			if (!await DeviceEntity.powerExists(serialNumber)) {
				return res.status(400).json({status:false,message: 'ورودی نامعتبر!'});
			}

			await DeviceEntity.removePower(serialNumber)
		}

		return res.json({status: true, message: 'دستگاه مورد نظر با موفقیت حذف شد!'})
	}
	catch (err) {
			console.error('inside remove device');
			console.error(err);

			return res.status(500).json({ message: 'خطایی پیش آمده',status:false });
		}
}