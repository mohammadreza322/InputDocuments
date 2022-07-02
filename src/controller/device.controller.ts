import { Response } from 'express';
import DeviceEntity from '../entities/device.entity';
import {
	addDeviceInput,
	deleteDeviceInput,
	listOfDevices,
} from '../types/device.type';
import { CustomRequest } from '../types/global.type';
export const saveDevice = async (req: CustomRequest, res: Response) => {
	try {
		const { type, serialNumber, name, category }: addDeviceInput = req.body;

		if (!type || !serialNumber || !name || !category) {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (serialNumber.trim() === '') {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (category.trim() === '') {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (name.trim() === '') {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		if (type != 'cooler' && type != 'power') {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumber(
			serialNumber,
			type,
			req.userId,
			'save',
		);
		if (!validateSerialNumber.valid) {
			return res
				.status(400)
				.json({ message: validateSerialNumber.message });
		}

		if (type == 'cooler') {
			const { brand, model }: addDeviceInput = req.body;

			if (!brand || !model) {
				return res.status(400).json({ message: 'خطا در ورودی' });
			}

			if (brand!.trim() === '') {
				return res
					.status(400)
					.json({ message: 'برند کولر را وارد نکرده اید' });
			}

			if (model!.trim() === '') {
				return res
					.status(400)
					.json({ message: 'مدل کولر را وارد نکرده اید' });
			}

			//todo check validate brand and model

			await DeviceEntity.saveCooler(
				serialNumber,
				brand!,
				model!,
				name,
				category,
				req.userId,
			);
		} else if (type == 'power') {
			const {
				power1,
				power2,
				power3,
				power4,
				usb1,
				usb2,
			}: addDeviceInput = req.body;

			if (!power1 || !power2 || !power3 || !power4 || !usb1 || !usb2) {
				return res.status(400).json({ message: 'خطا در ورودی' });
			}

			if (power1.trim() === '') {
				return res
					.status(400)
					.json({ message: 'نام پریز 1 را وارد نکرده اید!' });
			}

			if (power2.trim() === '') {
				return res
					.status(400)
					.json({ message: 'نام پریز 2 را وارد نکرده اید!' });
			}

			if (power3.trim() === '') {
				return res
					.status(400)
					.json({ message: 'نام پریز 3 را وارد نکرده اید!' });
			}

			if (power4.trim() === '') {
				return res
					.status(400)
					.json({ message: 'نام پریز 4 را وارد نکرده اید!' });
			}

			if (usb1.trim() === '') {
				return res
					.status(400)
					.json({ message: 'نام پورت 1 را وارد نکرده اید!' });
			}

			if (usb2.trim() === '') {
				return res
					.status(400)
					.json({ message: 'نام پورت 2 را وارد نکرده اید!' });
			}

			await DeviceEntity.savePower(
				serialNumber,
				category,
				name,
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
		const { serialNumber, type }: deleteDeviceInput = req.body;

		if (!serialNumber || !type) {
			return res.status(400).json({ message: 'خطا در ورودی' });
		}

		const validateSerialNumber = await DeviceEntity.validateSerialNumber(
			serialNumber,
			type,
			req.userId,
			'delete',
		);

		if (!validateSerialNumber.valid) {
			return res
				.status(400)
				.json({ message: validateSerialNumber.message });
		}

		await DeviceEntity.deleteOwnerDevice(serialNumber, type);

		const devices = await DeviceEntity.getAllDevices(req.userId);

		return res.json({ message: 'دستگاه شما با موفقیت حذف شد', devices });
	} catch (err) {
		console.error('inside delete device');
		console.error(err);

		return res.status(500).json({ message: 'خطایی پیش آمده' });
	}
};
