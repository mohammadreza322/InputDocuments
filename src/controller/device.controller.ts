import { Response } from 'express';
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
