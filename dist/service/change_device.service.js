"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const mqtt_1 = require("mqtt");
const db_1 = __importDefault(require("../config/db"));
const device_model_1 = require("../models/device.model");
//import Device  from '../models/device.model';
const constants_1 = require("../utility/constants");
(0, db_1.default)().then(() => {
    try {
        const client = (0, mqtt_1.connect)(constants_1.brokerUrl, {
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
        client.on('message', (topic, message) => __awaiter(void 0, void 0, void 0, function* () {
            const changeCoolerRegex = /\/chisco\/change_cooler\/(.+)/.exec(topic);
            const changePowerRegex = /\/chisco\/change_power\/(.+)/.exec(topic);
            const changeScheduleRegex = /\/chisco\/change_schedule\/(.+)/.exec(topic);
            const connectedDeviceRegex = /\/event\/connected/.exec(topic);
            const disconnectDeviceRegex = /\/event\/disconnected/.exec(topic);
            const data = JSON.parse(message.toString('utf8'));
            if (changeCoolerRegex) {
                changeCooler(changeCoolerRegex[1], data);
            }
            else if (changePowerRegex) {
                changePower(changePowerRegex[1], data);
            }
            else if (changeScheduleRegex) {
                changeSchedule(changeScheduleRegex[1], data);
            }
            else if (connectedDeviceRegex) {
                changeConnectStatus(data);
            }
            else if (disconnectDeviceRegex) {
                changeDisconnectStatus(data);
            }
        }));
    }
    catch (e) {
        console.error('inside get message device event file');
        console.error(e);
        process.exit();
    }
});
function changeDisconnectStatus(payload) {
    return __awaiter(this, void 0, void 0, function* () {
        const serialNumber = payload.username;
        const lastConnection = payload.disconnected_at;
        const validSerialNumber = yield _deviceExists(serialNumber);
        if (!validSerialNumber.valid) {
            return;
        }
        if (validSerialNumber.type == 'power') {
            yield device_model_1.PowerStrip.updateOne({ serialNumber }, {
                $set: { deviceLastConnection: lastConnection },
            });
        }
        else {
            yield device_model_1.Cooler.updateOne({ serialNumber }, {
                $set: { deviceLastConnection: lastConnection },
            });
        }
    });
}
function changeConnectStatus(payload) {
    return __awaiter(this, void 0, void 0, function* () {
        const serialNumber = payload.username;
        const lastConnection = payload.disconnected_at;
        const validSerialNumber = yield _deviceExists(serialNumber);
        if (!validSerialNumber.valid) {
            return;
        }
        if (validSerialNumber.type == 'power') {
            yield device_model_1.PowerStrip.updateOne({ serialNumber }, {
                $set: { deviceLastConnection: lastConnection },
            });
        }
        else {
            yield device_model_1.Cooler.updateOne({ serialNumber }, {
                $set: { deviceLastConnection: lastConnection },
            });
        }
    });
}
function changeCooler(serialNumber, payload) {
    return __awaiter(this, void 0, void 0, function* () {
        const validSerialNumber = yield _deviceExists(serialNumber);
        if (!validSerialNumber.valid) {
            return;
        }
        yield device_model_1.Cooler.updateOne({ serialNumber }, {
            $set: {
                mode: payload.mode,
                fan: payload.fan,
                horizontalSwing: payload.swing_horizontal,
                verticalSwing: payload.swing_vertical,
                temp: payload.temp,
                timer: payload.timer,
                power: payload.power,
            },
        });
    });
}
function changePower(serialNumber, payload) {
    return __awaiter(this, void 0, void 0, function* () {
        const validSerialNumber = yield _deviceExists(serialNumber);
        if (!validSerialNumber.valid) {
            return;
        }
    });
}
function changeSchedule(serialNumber, payload) {
    return __awaiter(this, void 0, void 0, function* () { });
}
function _deviceExists(serialNumber) {
    return __awaiter(this, void 0, void 0, function* () {
        if (yield device_model_1.PowerStrip.exists({ serialNumber })) {
            return {
                type: 'power',
                valid: true,
            };
        }
        else if (yield device_model_1.Cooler.exists({ serialNumber })) {
            return {
                type: 'cooler',
                valid: true,
            };
        }
        return {
            valid: false,
            type: '',
        };
    });
}
//# sourceMappingURL=change_device.service.js.map