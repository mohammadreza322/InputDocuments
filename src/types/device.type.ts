import { ICooler, IPowerStrip } from '../models/device.model';

export interface listOfDevices {
	powers: Array<IPowerStrip>;
	coolers: Array<ICooler>;
	categories: Array<string>;
}
