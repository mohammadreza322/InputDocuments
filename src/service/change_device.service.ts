import { connect } from 'mqtt';
import connectDb from '../config/db';
import {
	Cooler,
	IPowerStripSchedule,
	ISchedule,
	PowerStrip,
	ScheduleStatus,
} from '../models/device.model';
//import Device  from '../models/device.model';
import { brokerUrl } from '../utility/constants';
import LogsEntity from '../entities/logs.entity';
import DeviceEntity from '../entities/device.entity';

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

			client.subscribe('/chisco/+/get', (err) => {
				if (err) {
					console.error('can not subscribe /chisco/+/get');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/+/get');
			});

			client.subscribe('/chisco/+/change', (err) => {
				if (err) {
					console.error('can not subscribe /chisco/+/change');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/+/change');
			});

			client.subscribe('/chisco/+/change_model_c', (err) => {
				if (err) {
					console.error('can not subscribe /chisco/+/change_model_c');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/+/change_model_c');
			});

			client.subscribe('/chisco/+/ack_schedule', (err) => {
				if (err) {
					console.error('can not subscribe /chisco/+/ack_schedule');
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/+/ack_schedule');
			});

			client.subscribe('/chisco/+/ack_delete_schedule', (err) => {
				if (err) {
					console.error(
						'can not subscribe /chisco/+/ack_delete_schedule',
					);
					console.error(err);
					process.exit(1);
				}
				console.log('subscribe /chisco/+/ack_delete_schedule');
			});
		});

		client.on('message', async (topic, message) => {
			// const changeCoolerRegex = /\/chisco\/change_cooler\/(.+)/.exec(
			//     topic,
			// );
			// const changePowerRegex = /\/chisco\/change_power\/(.+)/.exec(topic);
			// const changeScheduleRegex = /\/chisco\/change_schedule\/(.+)/.exec(
			//     topic,
			// );

			const changeDeviceRegex = /\/chisco\/(.*)\/get/.exec(topic);
			const republishRegex = /\/chisco\/(.*)\/change/.exec(topic);
			const changeModelRegex = /\/chisco\/(.*)\/change_model_c/.exec(
				topic,
			);

			const ackScheduleRegex = /\/chisco\/(.*)\/ack_schedule/.exec(topic);

			const ackDeleteScheduleRegex =
				/\/chisco\/(.*)\/ack_delete_schedule/.exec(topic);

			const connectedDeviceRegex = /\/event\/connected/.exec(topic);
			const disconnectDeviceRegex = /\/event\/disconnected/.exec(topic);

			const data = JSON.parse(message.toString('utf8'));

			if (changeDeviceRegex) {
				changeDevice(changeDeviceRegex[1], data);
			} else if (connectedDeviceRegex) {
				changeConnectStatus(data, client);
			} else if (disconnectDeviceRegex) {
				changeDisconnectStatus(data, client);
			} else if (changeModelRegex) {
				_deviceExists(republishRegex[1]).then((deviceExists) => {
					if (deviceExists.valid) {
						if (deviceExists.type == 'cooler') {
							changeModel(changeModelRegex[1], data.model);
							client.publish(
								`/chisco/${republishRegex[1]}/change_cooler_model`,
								JSON.stringify(data),
							);
						}
					}
				});
			} else if (ackDeleteScheduleRegex){
				ackDeleteSchedle(ackDeleteScheduleRegex[1],data)
			}
			else if (ackScheduleRegex) {
				ackSchedle(ackScheduleRegex[1], data);
			}
		});
	} catch (e) {
		console.error('inside get message device event file');
		console.error(e);
		process.exit();
	}
});

async function ackSchedle(serialNumber: string, payload: any) {
	console.log(`payload is:${payload}`);
	console.log(`serialNumber is:${payload}`);
	const validSerialNumber = await _deviceExists(serialNumber);
	console.log(validSerialNumber);
	if (validSerialNumber.valid) {
		if (validSerialNumber.type === 'power') {
			await PowerStrip.updateOne(
				{ serialNumber, 'schedule.customId': parseInt(payload) },
				{
					$set: {
						'schedule.$.scheduleStatus': ScheduleStatus.ACK,
					},
				},
			);
		} else if (validSerialNumber.type === 'cooler') {
			await Cooler.updateOne(
				{ serialNumber, 'schedule.customId': parseInt(payload) },
				{
					$set: {
						'schedule.$.scheduleStatus': ScheduleStatus.ACK,
					},
				},
			);
		}
	}
}

async function ackDeleteSchedle(serialNumber: string, payload: any) {
	console.log(`payload is:${payload}`);
	console.log(`serialNumber is:${payload}`);
	const validSerialNumber = await _deviceExists(serialNumber);
	console.log(validSerialNumber);
	if (validSerialNumber.valid) {
		if (validSerialNumber.type === 'power') {
			await PowerStrip.updateOne(
				{ serialNumber },
				{
                    $pull: { pendingDeleteCustomIds: parseInt(payload) }, // حذف customId از لیست pendingDeleteCustomIds
                },
			);
		} else if (validSerialNumber.type === 'cooler') {
			await Cooler.updateOne(
				{ serialNumber},
				{
                    $pull: { pendingDeleteCustomIds: parseInt(payload) }, // حذف customId از لیست pendingDeleteCustomIds
                },
			);
		}
	}
}

async function changeDisconnectStatus(payload: any, client: any) {
	try {
		const serialNumber = payload.username;
		const lastConnection = payload.disconnected_at;
		const validSerialNumber = await _deviceExists(serialNumber);
		if (!validSerialNumber.valid) {
			return;
		}

		if (validSerialNumber.type == 'power') {
			await PowerStrip.updateOne(
				{ serialNumber },
				{
					$set: { deviceLastConnection: lastConnection },
				},
			);
		} else {
			await Cooler.updateOne(
				{ serialNumber },
				{
					$set: { deviceLastConnection: lastConnection },
				},
			);
		}

		client.publish(
			`/connection/${serialNumber}`,
			JSON.stringify({
				connectionStatus: false,
			}),
		);

		await LogsEntity.deviceDisconnectToServer(serialNumber);
	} catch (e) {
		console.error('inside chang disconnect');
		console.error(e);
	}
}

async function changeConnectStatus(payload: any, client) {
	try {
		const serialNumber = payload.username;

		const validSerialNumber = await _deviceExists(serialNumber);
		if (!validSerialNumber.valid) {
			return;
		}

		if (validSerialNumber.type == 'power') {
			console.log('power online');
			await PowerStrip.updateOne(
				{ serialNumber },
				{
					$set: { deviceLastConnection: 'آنلاین' },
				},
			);
		} else {
			console.log('cooler online');
			await Cooler.updateOne(
				{ serialNumber },
				{
					$set: { deviceLastConnection: 'آنلاین' },
				},
			);
		}

		setTimeout(async () => {
			const schedules = await DeviceEntity.getNotSavedSchedule(
				serialNumber,
				validSerialNumber.type,
			);

			console.log('schedules is ');
			console.log(schedules);

			const sendScheduleWithDelay = async (data, index) => {
				console.log(data)
				return new Promise((resolve) => {
					setTimeout(async () => {
						if (data.type == 'not_saved') {
							let schedule = data.data
							let scheduleObject = {
								enable: schedule.enable,
								startTime: schedule.start,
								endTime: schedule.end,
								repeat: schedule.repeat,
								id: schedule.customId.toString(),
							};
							if (validSerialNumber.type == 'power') {
								scheduleObject['port'] = (
									schedule as IPowerStripSchedule
								).port;
							}
							client.publish(
								`/chisco/set_schedule/${serialNumber}`,
								JSON.stringify(scheduleObject),
							);
							console.log(`Schedule ${index + 1} sent`);
							resolve(true);
						} else if (data.type == "delete") {
							client.publish(
								`/chisco/delete_schedule/${serialNumber}`,
								JSON.stringify({id:data.data.toString()}),
							);

							resolve(true);
						}
					}, index * 500); // تاخیر ۲ ثانیه بین هر schedule
				});
			};

			// ارسال همه schedule‌ها یکی یکی
			for (let i = 0; i < schedules.length; i++) {
				await sendScheduleWithDelay(schedules[i], i);
			}
		}, 1000);

		client.publish(
			`/connection/${serialNumber}`,
			JSON.stringify({
				connectionStatus: true,
			}),
		);

		await LogsEntity.deviceReconnectToServer(serialNumber);
	} catch (e) {
		console.error('inside change connection');
		console.error(e);
	}
}

async function changeDevice(serialNumber: string, payload: any) {
	try {
		const validSerialNumber = await _deviceExists(serialNumber);
		// console.log(validSerialNumber)
		if (validSerialNumber.valid) {
			if (validSerialNumber.type == 'power') {
				const power = await PowerStrip.findOne({ serialNumber });
				const connectors = power.connectors;

				console.log(payload);
				for (const connector of payload.ports) {
					console.log(connector);
					const index = connectors.findIndex((c) => {
						return c.connectorId == connector.portNumber;
					});
					// console.log(index)
					// console.log(connector)
					// console.log(connectors)
					const c = connectors[index];
					c.status = connector.status;
					connectors[index] = c;
				}

				power.connectors = connectors;
				power.totalVoltage = payload.totalVoltage;
				console.log('power changed');
				console.log(payload);
				console.log(power.connectors);
				await power.save();

				// await PowerStrip.updateOne(
				// 	{serialNumber},
				// 	{
				// 		$set: {
				//
				// 		},
				// 	},
				// );
			} else {
				console.log('cooler changed');
				// console.log(payload)
				payload = payload.cooler;
				await Cooler.updateOne(
					{ serialNumber },
					{
						$set: {
							timer: payload.timer,
							mode: payload.mode,
							horizontalSwing: payload.horizontalSwing,
							verticalSwing: payload.verticalSwing,
							fan: payload.fan,
							temp: payload.temp,
							power: payload.status,
						},
					},
				);
			}
		}
	} catch (e) {
		console.error('inside change power device');
		console.error(e);
	}
}

async function changeModel(serialNumber: string, model: string) {
	try {
		await Cooler.updateOne(
			{ serialNumber },
			{
				$set: {
					model,
				},
			},
		);
	} catch (e) {
		console.error('inside change model');
		console.error(e);
	}
}

async function _deviceExists(serialNumber: string) {
	try {
		if (await PowerStrip.exists({ serialNumber })) {
			return {
				type: 'power',
				valid: true,
			};
		} else if (await Cooler.exists({ serialNumber })) {
			return {
				type: 'cooler',
				valid: true,
			};
		}

		return {
			valid: false,
			type: '',
		};
	} catch (e) {
		console.error('inside device exists');
		console.error(e);
	}
}
