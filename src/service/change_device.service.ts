import { connect } from 'mqtt';
import connectDb from '../config/db';
import Device from '../models/device.model';
import { brokerUrl } from '../utility/constants';
connectDb().then(() => {
	try {
		const client = connect(brokerUrl, {
			clean: true,
			connectTimeout: 4000,
			username: 'backend',
			password: 'gZZavYpF',
		});

		client.on('connect', () => {
			console.log('connected');

			client.subscribe('/event/disconnected', (err) => {
				if (err) {
					console.error('can not subscribe /event/disconnected');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe disconnect');
			});

			client.subscribe('/event/connected', (err) => {
				if (err) {
					console.error('can not subscribe /event/connected');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe connect');
			});

			client.subscribe('/chisco/change_cooler/#', (err) => {
				if (err) {
					console.error('can not subscribe /chisco/change_cooler');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/change_cooler');
			});

			client.subscribe('/chisco/change_schedule/#', (err) => {
				if (err) {
					console.error('can not subscribe /chisco/change_schedule');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/change_schedule');
			});

			client.subscribe('/chisco/change_power/#', (err) => {
				if (err) {
					console.error('can not subscribe /chisco/change_power');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/change_power');
			});
		});

		client.on('message', async (topic, message) => {
			const changeCoolerRegex = /\/chisco\/change_cooler\/(.+)/.exec(
				topic,
			);
			const changePowerRegex = /\/chisco\/change_power\/(.+)/.exec(topic);
			const changeScheduleRegex = /\/chisco\/change_schedule\/(.+)/.exec(
				topic,
			);
			const connectedDeviceRegex = /\/event\/connected/.exec(topic);
			const disconnectDeviceRegex = /\/event\/disconnected/.exec(topic);

			const data = JSON.parse(message.toString('utf8'));

			if (changeCoolerRegex) {
				changeCooler(changeCoolerRegex[1], data);
			} else if (changePowerRegex) {
				changePower(changePowerRegex[1], data);
			} else if (changeScheduleRegex) {
				changeSchedule(changeScheduleRegex[1], data);
			} else if (connectedDeviceRegex) {
				changeConnectStatus(data);
			} else if (disconnectDeviceRegex) {
				changeDisconnectStatus(data);
			}
		});
	} catch (e) {
		console.error('inside get message device event file');
		console.error(e);
		process.exit();
	}
});

async function changeDisconnectStatus(payload: any) {
	const serialNumber = payload.username;
	const lastConnection = payload.disconnected_at;
	if (!(await _deviceExists(serialNumber))) {
		return;
	}

	await Device.updateOne(
		{ serialNumber },
		{ $set: { deviceLastConnection: lastConnection } },
	);
}

async function changeConnectStatus(payload: any) {
	const serialNumber = payload.username;
	const lastConnection = payload.disconnected_at;

	if (!(await _deviceExists(serialNumber))) {
		return;
	}

	await Device.updateOne(
		{ serialNumber },
		{ $set: { deviceLastConnection: lastConnection } },
	);
}

async function changeCooler(serialNumber: string, payload: any) {
	if (!(await _deviceExists(serialNumber))) {
		return;
	}

	await Device.updateOne(
		{ serialNumber },
		{
			$set: {
				details: {
					mode: payload.mode,
					fan: payload.fan,
					swing_horizontal: payload.swing_horizontal,
					swing_vertical: payload.swing_vertical,
					temp: payload.temp,
					timer: payload.timer,
					power: payload.power,
				},
			},
		},
	);
}

async function changePower(serialNumber: string, payload: any) {
	if (!(await _deviceExists(serialNumber))) {
		return;
	}

	await Device.updateOne(
		{ serialNumber },
		{
			$set: {
				details: {
					relay1: payload.relay1,
					relay2: payload.relay2,
					relay3: payload.relay3,
					relay4: payload.relay4,
				},
			},
		},
	);
}

async function changeSchedule(serialNumber: string, payload: any) {}

function _deviceExists(serialNumber: string) {
	return Device.exists({ serialNumber });
}
