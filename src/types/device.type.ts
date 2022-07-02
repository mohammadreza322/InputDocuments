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
}

export interface deleteDeviceInput {
	serialNumber: string;
	type: string;
}
