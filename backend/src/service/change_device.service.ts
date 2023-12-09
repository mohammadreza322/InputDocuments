import { connect } from 'mqtt';
import connectDb from '../config/db';
import { Cooler, PowerStrip } from '../models/device.model';
//import Device  from '../models/device.model';
import { brokerUrl } from '../utility/constants';
import LogsEntity from '../entities/logs.entity';

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

			const connectedDeviceRegex = /\/event\/connected/.exec(topic);
			const disconnectDeviceRegex = /\/event\/disconnected/.exec(topic);

			const data = JSON.parse(message.toString('utf8'));

			if (changeDeviceRegex) {
				changeDevice(changeDeviceRegex[1], data);
			} else if (connectedDeviceRegex) {
				changeConnectStatus(data);
			} else if (disconnectDeviceRegex) {
				changeDisconnectStatus(data);
			}  else if (changeModelRegex) {
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
			}
		});
	} catch (e) {
		console.error('inside get message device event file');
		console.error(e);
		process.exit();
	}
});

async function changeDisconnectStatus(payload: any) {
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

		await LogsEntity.deviceDisconnectToServer(serialNumber);
	} catch (e) {
		console.error('inside chang disconnect');
		console.error(e);
	}
}

async function changeConnectStatus(payload: any) {
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
