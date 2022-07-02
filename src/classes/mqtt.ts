import * as mqtt from 'mqtt';
import { brokerUrl } from '../utility/constants';

export default class AhpMqtt {
	private static instance: AhpMqtt;

	private constructor() {}

	private client?: mqtt.MqttClient;

	public static getInstance(): AhpMqtt {
		if (!AhpMqtt.instance) {
			AhpMqtt.instance = new AhpMqtt();
		}

		return AhpMqtt.instance;
	}

	public connect() {
		const options: mqtt.IClientOptions = {
			clientId: `backend_server_${Date.now()}`,
			clean: true,
			connectTimeout: 4000,
			username: 'backend',
			password: 'gZZavYpF',
		};

		this.client = mqtt.connect(brokerUrl, options);

		console.log('connect to broker...');

		this.client.on('close', () => {
			console.log('connection to broker closed');
		});

		this.client.on('disconnect', () => {
			console.log('disconnect from broker');
		});

		this.client.on('connect', () => {
			console.log('server connected to the broker');
		});
	}

	public subscribe(topic: string) {
		this.client?.subscribe(topic);
	}

	public publish(topic: string, message: string) {
		this.client?.publish(topic, message);
	}
}
