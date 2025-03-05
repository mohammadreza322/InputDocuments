import { Types } from 'mongoose';
import {ICooler, IPowerStrip, IPowerStripSchedule, PowerConnectors} from '../models/device.model';

export interface listOfDevices {
	powers: Array<PowerStripsForApi>;
	coolers: Array<CoolerForApi>;
	categories: Array<string>;
}

interface PowerStripsForApi {
	connectionStatus:boolean;
	connectors:Array<PowerConnectors>;
	totalVoltage: Number;
	schedule: Array<IPowerStripSchedule>;
	serialNumber: string;
	name?: string;
	category?: string;
	owner?: Types.ObjectId;
	deviceLastConnection?:string;
}

interface CoolerForApi {
	serialNumber: string;
	name?: string;
	category?: string;
	owner?: Types.ObjectId;
	deviceLastConnection?:string;
	schedule: Array<IPowerStripSchedule>;
	connectionStatus:boolean;
	model?: string;
	temp?: number;
	mode: string;
	horizontalSwing: string;
	verticalSwing: string;
	fan: string;
	timer: string;
	power?: boolean;
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
	id?: String;
	enable: boolean;
}

export interface deleteDeviceInput {
	serialNumber: string;
	id: string;
}
