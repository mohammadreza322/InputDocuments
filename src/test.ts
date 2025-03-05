import connectDb from './config/db';
import { Cooler, ICooler, IPowerStrip, IPowerStripSchedule, PowerStrip } from './models/device.model';

connectDb().then(async () => {
	const power: IPowerStrip[] | null = await PowerStrip.find({});
	let counter = 0;
	for(const device of power) {
		await new Promise(resolve => setTimeout(resolve, 500));
		for(const schedule of device.schedule) {
			const randomOffset = Math.floor(Math.random() * 1000); // یک عدد رندوم بین ۰ تا ۹۹۹

			schedule.customId = Math.floor( (Date.now() - randomOffset)/1000)+counter
			counter++
		}
		await device.save()
		console.log(`power ${device.serialNumber} saved`)
		
	}

	const coolers: ICooler[] | null = await Cooler.find({});
	for(const device of coolers) {
		for(const schedule of device.schedule) {
			await new Promise(resolve => setTimeout(resolve, 500));
			const randomOffset = Math.floor(Math.random() * 1000); // یک عدد رندوم بین ۰ تا ۹۹۹
            

			schedule.customId = Math.floor( (Date.now() - randomOffset)/1000)+counter
			counter++
		}

		await device.save()
		console.log(`cooler ${device.serialNumber} saved`)
		
	}
	console.log("done")
	process.exit()
})