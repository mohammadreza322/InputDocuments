import connectDb from './config/db';
import {
	ICooler,
	IPowerStrip,
	PowerStrip,
	Cooler,
} from './models/device.model';

connectDb().then(async () => {
	const coolerDoc = {
		serialNumber: 'cooler_ahp_3',

		schedule: [],
	};

	const a = new Cooler(coolerDoc);
	await a.save();
	console.log('done');
	process.exit(0);
});
