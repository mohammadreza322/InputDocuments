import { Types, ObjectId } from 'mongoose';
import AhpMqtt from '../classes/mqtt';
import {
	Cooler,
	ICooler,
	IPowerStrip,
	PowerStrip,
} from '../models/device.model';
// import Device from '../models/device.model';
import {
	saveScheduleInput,
	listOfDevices,
	validateSerialNumberOutput,
	addSchedule,
	IScheduleObject,
	editSchedule,
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
		userId: Types.ObjectId,
		validateType: string,
	): Promise<validateSerialNumberOutput> {
		const output: validateSerialNumberOutput = {
			message: '',
			valid: false,
			type: '',
		};

		output.message = 'شماره سریال وارد شده معتبر نیست!';

		const powerDetails = await PowerStrip.findOne({ serialNumber });

		const coolerDetails = await Cooler.findOne({ serialNumber });

		var device = undefined;

		if (!powerDetails && !coolerDetails) {
			return output;
		}

		if (powerDetails) {
			device = powerDetails;
			output.type = 'power';
		} else if (coolerDetails) {
			device = coolerDetails;
			output.type = 'cooler';
		} else {
			return output;
		}

		if (device?.owner) {
			if (!userId.equals(device.owner)) {
				output.message = 'این دستگاه قبلا ثبت شده است';
				return output;
			}
		} else {
			if (validateType === 'delete' || validateType === 'addSchedule') {
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
		power1?: string,
		power2?: string,
		power3?: string,
		power4?: string,
		usb1?: string,
		usb2?: string,
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
							name: power1 ?? '',
							connectorType: 'power',
							status: true,
							connectorId: 1,
						},
						{
							name: power2 ?? '',
							connectorType: 'power',
							status: true,
							connectorId: 2,
						},
						{
							name: power3 ?? '',
							connectorType: 'power',
							status: true,
							connectorId: 3,
						},
						{
							name: power4 ?? '',
							connectorType: 'power',
							status: true,
							connectorId: 4,
						},
						{
							name: usb1 ?? '',
							connectorType: 'usb',
							status: true,
							connectorId: 5,
						},
						{
							name: usb2 ?? '',
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

	static async addSchedule({
		serialNumber,
		startTime,
		endTime,
		repeat,
		portNumber,
		type,
	}: addSchedule) {
		const scheduleObject: IScheduleObject = {
			endTime,
			startTime,
			repeat,
			enable: true,
		};
		if (type === 'power') {
			scheduleObject.port = portNumber;

			const power: IPowerStrip | null = await PowerStrip.findOne({
				serialNumber,
			});

			if (power) {
				power.schedule.push({
					start: startTime?.toString(),
					end: endTime?.toString(),
					repeat,
					port: portNumber,
					enable: true,
				});
				await power.save();

				scheduleObject.id =
					power.schedule[power.schedule.length - 1]._id;
			}
		} else if (type === 'cooler') {
			const cooler: ICooler | null = await Cooler.findOne({
				serialNumber,
			});
			if (cooler) {
				cooler.schedule.push({
					start: startTime?.toString(),
					end: endTime?.toString(),
					repeat,
					enable: true,
				});
				await cooler.save();

				scheduleObject.id =
					cooler.schedule[cooler.schedule.length - 1]._id;
			}
		}

		AhpMqtt.getInstance().publish(
			`/chisco/set_schedule/${serialNumber}`,
			JSON.stringify(scheduleObject),
		);
	}

	static async editSchedule({
		serialNumber,
		startTime,
		endTime,
		repeat,
		portNumber,
		type,
		enable,
		_id,
	}: editSchedule) {
		const scheduleObject: IScheduleObject = {
			id: new Types.ObjectId(_id),
			enable: enable!,
			startTime,
			endTime,
			repeat,
		};

		if (type === 'power') {
			scheduleObject.port = portNumber;
			await PowerStrip.updateOne(
				{ serialNumber, 'schedule._id': _id },
				{
					$set: {
						'schedule.$.start': startTime,
						'schedule.$.end': endTime,
						'schedule.$.repeat': repeat,
						'schedule.$.port': portNumber,
						'schedule.$.enable': enable,
					},
				},
			);
		} else if (type === 'cooler') {
			await Cooler.updateOne(
				{ serialNumber, 'schedule._id': _id },
				{
					$set: {
						'schedule.$.start': startTime,
						'schedule.$.end': endTime,
						'schedule.$.repeat': repeat,
						'schedule.$.enable': enable,
					},
				},
			);
		}

		AhpMqtt.getInstance().publish(
			`/chisco/set_schedule/${serialNumber}`,
			JSON.stringify(scheduleObject),
		);
	}

	static async deleteSchedule(
		serialNumber: string,
		id: Types.ObjectId,
		type: string,
	): Promise<void> {
		if (type == 'power') {
			await PowerStrip.updateOne(
				{ serialNumber },
				{
					$pull: {
						schedule: {
							_id: id,
						},
					},
				},
			);
		} else if (type == 'cooler') {
			await Cooler.updateOne(
				{ serialNumber: serialNumber },
				{
					$pull: {
						schedule: {
							_id: id,
						},
					},
				},
			);
		}
		AhpMqtt.getInstance().publish(
			`/chisco/delete_schedule/${serialNumber}`,
			JSON.stringify({ id }),
		);
	}
}
