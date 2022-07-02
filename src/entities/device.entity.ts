import { ObjectId, Types } from 'mongoose';
import {
	Cooler,
	ICooler,
	IPowerStrip,
	PowerStrip,
} from '../models/device.model';
// import Device from '../models/device.model';
import { listOfDevices } from '../types/device.type';

export default class DeviceEntity {
	static async getAllDevices(userId: Types.ObjectId) {
		const powerStrips: Array<IPowerStrip> | null = await PowerStrip.find({
			owner: userId,
		});

		const coolers: Array<ICooler> | null = await Cooler.find({
			owner: userId,
		});

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
}
