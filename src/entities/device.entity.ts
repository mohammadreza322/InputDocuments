import { ObjectId, Types } from 'mongoose';
import AhpMqtt from '../classes/mqtt';
import {
	Cooler,
	ICooler,
	IPowerStrip,
	PowerStrip,
} from '../models/device.model';
// import Device from '../models/device.model';
import {
	listOfDevices,
	validateSerialNumberOutput,
} from '../types/device.type';

export default class DeviceEntity {
	static async getAllDevices(userId: Types.ObjectId) {
		const powerStrips: Array<IPowerStrip> | null = await PowerStrip.find(
			{
				owner: userId,
			},
			{ _id: 0, 'connectors._id': 0, __v: 0, registerAt: 0, owner: 0 },
		);

		const coolers: Array<ICooler> | null = await Cooler.find(
			{
				owner: userId,
			},
			{ _id: 0, __v: 0, owner: 0, registerAt: 0 },
		);

		const devices: listOfDevices = {
			powers: [],
			coolers: [],
			categories: [],
		};

		for (const power of powerStrips) {
			devices.powers.push(power);
			if (power.category) {
				if (!devices.categories.includes(power.category)) {
					devices.categories.push(power.category);
				}
			}
		}

		for (const cooler of coolers) {
			devices.coolers.push(cooler);
			if (cooler.category) {
				if (!devices.categories.includes(cooler.category)) {
					devices.categories.push(cooler.category);
				}
			}
		}

		return devices;
	}

	static async validateSerialNumber(
		serialNumber: string,
		type: string,
		userId: Types.ObjectId,
		validateType: string,
	): Promise<validateSerialNumberOutput> {
		const output: validateSerialNumberOutput = {
			message: '',
			valid: false,
		};

		output.message = 'شماره سریال وارد شده معتبر نیست!';

		const powerDetails = await PowerStrip.findOne({ serialNumber });

		const coolerDetails = await Cooler.findOne({ serialNumber });

		var device = undefined;

		if (!powerDetails && !coolerDetails) {
			return output;
		}

		if (powerDetails && type != 'power') {
			return output;
		} else if (powerDetails && type == 'power') {
			device = powerDetails;
		}

		if (coolerDetails && type != 'cooler') {
			return output;
		} else if (coolerDetails && type == 'cooler') {
			device = coolerDetails;
		}

		if (device?.owner) {
			if (!userId.equals(device.owner)) {
				output.message = 'این دستگاه قبلا ثبت شده است';
				return output;
			}
		} else {
			if (validateType === 'delete') {
				output.message = 'شما مالک این دستگاه نیستید';
				return output;
			}
		}

		output.valid = true;
		return output;
	}

	static async saveCooler(
		serialNumber: string,
		brand: string,
		model: string,
		name: string,
		category: string,
		userId: Types.ObjectId,
	) {
		await Cooler.updateOne(
			{ serialNumber },
			{
				$set: {
					brand,
					model,
					name,
					category,
					owner: userId,
					registerAt: Date.now(),
				},
			},
		);

		AhpMqtt.getInstance().publish(
			`/chisco/change_model/${serialNumber}`,
			JSON.stringify({ brand, model }),
		);
	}

	static async savePower(
		serialNumber: string,
		category: string,
		name: string,
		userId: Types.ObjectId,
		power1: string,
		power2: string,
		power3: string,
		power4: string,
		usb1: string,
		usb2: string,
	) {
		await PowerStrip.updateOne(
			{ serialNumber },
			{
				$set: {
					name,
					category,
					owner: userId,
					connectors: [
						{
							name: power1,
							connectorType: 'power',
							status: true,
							connectorId: 1,
						},
						{
							name: power2,
							connectorType: 'power',
							status: true,
							connectorId: 2,
						},
						{
							name: power3,
							connectorType: 'power',
							status: true,
							connectorId: 3,
						},
						{
							name: power4,
							connectorType: 'power',
							status: true,
							connectorId: 4,
						},
						{
							name: usb1,
							connectorType: 'usb',
							status: true,
							connectorId: 5,
						},
						{
							name: usb2,
							connectorType: 'usb',
							status: true,
							connectorId: 6,
						},
					],
					registerAt: Date.now(),
				},
			},
		);
	}

	static async deleteOwnerDevice(serialNumber: string, type: string) {
		if (type === 'cooler') {
			await Cooler.updateOne(
				{ serialNumber: serialNumber },
				{
					$set: {
						owner: null,
						name: null,
						category: null,
						schedule: [],
						registerAt: null,
						temp: null,
						mode: 'Auto',
						horizontalSwing: 'Auto',
						verticalSwing: 'Auto',
						fan: 'Auto',
						timer: 'Off',
					},
				},
			);
		} else if (type === 'power') {
			await PowerStrip.updateOne(
				{ serialNumber },
				{
					$set: {
						owner: null,
						name: null,
						category: null,
						schedule: [],
						registerAt: null,
						totalVoltage: 0,
						connectors: [],
					},
				},
			);
		}

		AhpMqtt.getInstance().publish(
			`/chisco/deleteOwner/${serialNumber}`,
			JSON.stringify({ delete: true }),
		);
		return true;
	}
}
