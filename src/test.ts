import connectDb from './config/db';
import {
	ICooler,
	IPowerStrip,
	PowerStrip,
	Cooler,
} from './models/device.model';

connectDb().then(async () => {
	for (let i: number = 0; i < 10; i++) {
		const newPowerInputs = {
			serialNumber: 'power_ahp_' + i,
			connectors: [
				{ portNumber: 1, type: 'power', status: true },
				{ portNumber: 2, type: 'power', status: true },
				{ portNumber: 3, type: 'power', status: false },
				{ portNumber: 4, type: 'power', status: false },
				{ portNumber: 1, type: 'usb', status: false },
				{ portNumber: 2, type: 'usb', status: true },
			],
			totalVoltage: 120,
			schedule: [],
		};

		const powerStrip = new PowerStrip(newPowerInputs);
		await powerStrip.save();
		console.log('done');
	}

	process.exit(0);
});
