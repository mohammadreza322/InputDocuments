import { Schema, model, Document, Model, Types } from 'mongoose';

const scheduleDeviceDefaultSchema = {
	name: {
		type: 'string',
	},
	start: {
		type: 'string',
	},
	end: {
		type: 'string',
	},
	repeat: {
		default: [],
		type: [{ type: Array<string> }],
	},
};

const defaultDeviceSchema = {
	serialNumber: {
		type: 'string',
		required: true,
	},
	name: {
		type: 'string',
	},
	category: {
		type: 'string',
	},
	registerAt:{
		type:Date,
	},
	owner:{
		type:Types.ObjectId
	}
};

interface IDevice extends Document{
	serialNumber: string;
	name?: string;
	category?: string;
	owner?: Types.ObjectId;
	registerAt?:Date;
}

interface ISchedule {
	name?: string;
	start?: string;
	end?: string;
	repeat?: Array<string>;
}

interface PowerConnectors {
	status: boolean;
	name?: string;
	type: string;
	portNumber: number;
}

interface IPowerStripSchedule extends ISchedule {
	port?: 'string';
}

export interface IPowerStrip extends IDevice {
	connectors: Array<PowerConnectors>;
	totalVoltage: Number;
	schedule: Array<IPowerStripSchedule>;
}

export interface ICooler extends IDevice {
	brand?: string;
	model?: string;
	temp?: number;
	mode: string;
	horizontalSwing: string;
	verticalSwing: string;
	fan: string;
	timer: string;
	schedule: Array<ISchedule>;
}

const powerStripSchema = new Schema({
	...defaultDeviceSchema,
	connectors: {
		type: [
			{
				status: Boolean,
				name: String,
				connectorType: {
					type: String,
					enum: ['usb', 'power'],
				},
				connectorId: Number,
			},
		],
		default: [],
	},
	totalVoltage: {
		type: Number,
		default: 0,
	},
	schedule: {
		type: [
			{
				port: Number,
				name: String,
				start: String,
				end: String,
				repeat: {
					type: [{ type: String }],
					default: [],
				},
			},
		],
		default: [],
	},
});

export const PowerStrip: Model<IPowerStrip> = model<IPowerStrip>(
	'PowerStrip',
	powerStripSchema,
);

const coolerSchema = new Schema({
	...defaultDeviceSchema,
	brand: {
		type: String,
	},
	model: {
		type: String,
	},
	temp: {
		type: Number,
	},
	mode: {
		type: String,
		default: 'Auto',
	},
	horizontalSwing: {
		type: String,
		default: 'Auto',
	},
	verticalSwing: {
		type: String,
		default: 'Auto',
	},
	fan: {
		type: String,
		default: 'Auto',
	},
	timer: {
		type: String,
		default: 'Off',
	},
	schedule: {
		type: [scheduleDeviceDefaultSchema],
		default: [] 
	},
});

export const Cooler: Model<ICooler> = model<ICooler>('Cooler', coolerSchema);
