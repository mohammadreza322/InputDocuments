import { ObjectId } from 'mongoose';
// import Device from '../models/device.model';
import { listOfDevicesOutPut } from '../types/device.type';

export default class DeviceEntity {
	static async getAllDevices(userId: ObjectId) {
		// const listOfDevices = await Device.find({ owner: userId });
		// const categories = [];
		// for (const device of listOfDevices) {
		// 	categories.push(device.category);
		// }
		// return {
		// 	devices: listOfDevices.length > 0 ? listOfDevices : [],
		// 	categories,
		// } as listOfDevicesOutPut;
	}
}
