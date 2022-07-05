import { Types } from 'mongoose';
import { ICooler, IPowerStrip } from '../models/device.model';

export interface listOfDevices {
	powers: Array<IPowerStrip>;
	coolers: Array<ICooler>;
	categories: Array<string>;
}

export interface addDeviceInput {
	type: string;
	serialNumber: string;
	name: string;
	category: string;
	brand?: string;
	model?: string;
	power1?: string;
	power2?: string;
	power3?: string;
	power4?: string;
	usb1?: string;
	usb2?: string;
}

export interface validateSerialNumberOutput {
	message: string;
	valid: boolean;
	type: string;
}

export interface deleteDeviceInput {
	serialNumber: string;
	type: string;
}

export interface saveScheduleInput {
	startTime?: string;
	endTime?: string;
	repeat: Array<string>;
	portNumber?: number;
	serialNumber: string;
	type?: string;
	enable?: boolean;
	id?: string;
}

export interface editSchedule extends saveScheduleInput {
	_id: Types.ObjectId;
}

export interface addSchedule {
	startTime?: string;
	endTime?: string;
	repeat: Array<string>;
	portNumber?: number;
	serialNumber: string;
	type?: string;
}

export interface IScheduleObject {
	startTime?: string;
	endTime?: string;
	repeat: Array<string>;
	port?: number;
	id?: Types.ObjectId;
	enable: boolean;
}

export interface deleteDeviceInput {
	serialNumber: string;
	id: string;
}
