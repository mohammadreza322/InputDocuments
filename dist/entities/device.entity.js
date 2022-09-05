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
const mongoose_1 = require("mongoose");
const mqtt_1 = __importDefault(require("../classes/mqtt"));
const device_model_1 = require("../models/device.model");
class DeviceEntity {
    static getAllDevices(userId) {
        return __awaiter(this, void 0, void 0, function* () {
            const powerStrips = yield device_model_1.PowerStrip.find({
                owner: userId,
            }, { _id: 0, 'connectors._id': 0, __v: 0, registerAt: 0, owner: 0 });
            const coolers = yield device_model_1.Cooler.find({
                owner: userId,
            }, { _id: 0, __v: 0, owner: 0, registerAt: 0 });
            const devices = {
                powers: [],
                coolers: [],
                categories: [],
            };
            for (const power of powerStrips) {
                devices.powers.push(power);
                if (power.category) {
                    if (!devices.categories.includes(power.category)) {
                        devices.categories.push(power.category);
                    }
                }
            }
            for (const cooler of coolers) {
                devices.coolers.push(cooler);
                if (cooler.category) {
                    if (!devices.categories.includes(cooler.category)) {
                        devices.categories.push(cooler.category);
                    }
                }
            }
            return devices;
        });
    }
    static validateSerialNumber(serialNumber, userId, validateType) {
        return __awaiter(this, void 0, void 0, function* () {
            const output = {
                message: '',
                valid: false,
                type: '',
            };
            output.message = 'شماره سریال وارد شده معتبر نیست!';
            const powerDetails = yield device_model_1.PowerStrip.findOne({ serialNumber });
            const coolerDetails = yield device_model_1.Cooler.findOne({ serialNumber });
            var device = undefined;
            if (!powerDetails && !coolerDetails) {
                return output;
            }
            if (powerDetails) {
                device = powerDetails;
                output.type = 'power';
            }
            else if (coolerDetails) {
                device = coolerDetails;
                output.type = 'cooler';
            }
            else {
                return output;
            }
            if (device === null || device === void 0 ? void 0 : device.owner) {
                if (!userId.equals(device.owner)) {
                    output.message = 'این دستگاه قبلا ثبت شده است';
                    return output;
                }
            }
            else {
                if (validateType === 'delete' || validateType === 'addSchedule') {
                    output.message = 'شما مالک این دستگاه نیستید';
                    return output;
                }
            }
            output.valid = true;
            return output;
        });
    }
    static saveCooler(serialNumber, model, name, category, userId) {
        return __awaiter(this, void 0, void 0, function* () {
            yield device_model_1.Cooler.updateOne({ serialNumber }, {
                $set: {
                    model,
                    name,
                    category,
                    owner: userId,
                    registerAt: Date.now(),
                },
            });
            mqtt_1.default.getInstance().publish(`/chisco/change_model/${serialNumber}`, JSON.stringify({ model }));
        });
    }
    static savePower(serialNumber, category, name, userId, power1, power2, power3, power4, usb1, usb2) {
        return __awaiter(this, void 0, void 0, function* () {
            yield device_model_1.PowerStrip.updateOne({ serialNumber }, {
                $set: {
                    name,
                    category,
                    owner: userId,
                    connectors: [
                        {
                            name: power1 !== null && power1 !== void 0 ? power1 : '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 1,
                        },
                        {
                            name: power2 !== null && power2 !== void 0 ? power2 : '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 2,
                        },
                        {
                            name: power3 !== null && power3 !== void 0 ? power3 : '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 3,
                        },
                        {
                            name: power4 !== null && power4 !== void 0 ? power4 : '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 4,
                        },
                        {
                            name: usb1 !== null && usb1 !== void 0 ? usb1 : '',
                            connectorType: 'usb',
                            status: true,
                            connectorId: 5,
                        },
                        {
                            name: usb2 !== null && usb2 !== void 0 ? usb2 : '',
                            connectorType: 'usb',
                            status: true,
                            connectorId: 6,
                        },
                    ],
                    registerAt: Date.now(),
                },
            });
        });
    }
    static deleteOwnerDevice(serialNumber, type) {
        return __awaiter(this, void 0, void 0, function* () {
            if (type === 'cooler') {
                yield device_model_1.Cooler.updateOne({ serialNumber: serialNumber }, {
                    $set: {
                        owner: null,
                        name: null,
                        category: null,
                        schedule: [],
                        registerAt: null,
                        temp: null,
                        mode: 'Auto',
                        horizontalSwing: 'Auto',
                        verticalSwing: 'Auto',
                        fan: 'Auto',
                        timer: 'Off',
                    },
                });
            }
            else if (type === 'power') {
                yield device_model_1.PowerStrip.updateOne({ serialNumber }, {
                    $set: {
                        owner: null,
                        name: null,
                        category: null,
                        schedule: [],
                        registerAt: null,
                        totalVoltage: 0,
                        connectors: [],
                    },
                });
            }
            mqtt_1.default.getInstance().publish(`/chisco/deleteOwner/${serialNumber}`, JSON.stringify({ delete: true }));
            return true;
        });
    }
    static addSchedule({ serialNumber, startTime, endTime, repeat, portNumber, type, }) {
        return __awaiter(this, void 0, void 0, function* () {
            const scheduleObject = {
                endTime,
                startTime,
                repeat,
                enable: true,
            };
            if (type === 'power') {
                scheduleObject.port = portNumber;
                const power = yield device_model_1.PowerStrip.findOne({
                    serialNumber,
                });
                if (power) {
                    power.schedule.push({
                        start: startTime === null || startTime === void 0 ? void 0 : startTime.toString(),
                        end: endTime === null || endTime === void 0 ? void 0 : endTime.toString(),
                        repeat,
                        port: portNumber,
                        enable: true,
                    });
                    yield power.save();
                    scheduleObject.id =
                        power.schedule[power.schedule.length - 1]._id;
                }
            }
            else if (type === 'cooler') {
                const cooler = yield device_model_1.Cooler.findOne({
                    serialNumber,
                });
                if (cooler) {
                    cooler.schedule.push({
                        start: startTime === null || startTime === void 0 ? void 0 : startTime.toString(),
                        end: endTime === null || endTime === void 0 ? void 0 : endTime.toString(),
                        repeat,
                        enable: true,
                    });
                    yield cooler.save();
                    scheduleObject.id =
                        cooler.schedule[cooler.schedule.length - 1]._id;
                }
            }
            mqtt_1.default.getInstance().publish(`/chisco/set_schedule/${serialNumber}`, JSON.stringify(scheduleObject));
        });
    }
    static editSchedule({ serialNumber, startTime, endTime, repeat, portNumber, type, enable, _id, }) {
        return __awaiter(this, void 0, void 0, function* () {
            const scheduleObject = {
                id: new mongoose_1.Types.ObjectId(_id),
                enable: enable,
                startTime,
                endTime,
                repeat,
            };
            if (type === 'power') {
                scheduleObject.port = portNumber;
                yield device_model_1.PowerStrip.updateOne({ serialNumber, 'schedule._id': _id }, {
                    $set: {
                        'schedule.$.start': startTime,
                        'schedule.$.end': endTime,
                        'schedule.$.repeat': repeat,
                        'schedule.$.port': portNumber,
                        'schedule.$.enable': enable,
                    },
                });
            }
            else if (type === 'cooler') {
                yield device_model_1.Cooler.updateOne({ serialNumber, 'schedule._id': _id }, {
                    $set: {
                        'schedule.$.start': startTime,
                        'schedule.$.end': endTime,
                        'schedule.$.repeat': repeat,
                        'schedule.$.enable': enable,
                    },
                });
            }
            mqtt_1.default.getInstance().publish(`/chisco/set_schedule/${serialNumber}`, JSON.stringify(scheduleObject));
        });
    }
    static deleteSchedule(serialNumber, id, type) {
        return __awaiter(this, void 0, void 0, function* () {
            if (type == 'power') {
                yield device_model_1.PowerStrip.updateOne({ serialNumber }, {
                    $pull: {
                        schedule: {
                            _id: id,
                        },
                    },
                });
            }
            else if (type == 'cooler') {
                yield device_model_1.Cooler.updateOne({ serialNumber: serialNumber }, {
                    $pull: {
                        schedule: {
                            _id: id,
                        },
                    },
                });
            }
            mqtt_1.default.getInstance().publish(`/chisco/delete_schedule/${serialNumber}`, JSON.stringify({ id }));
        });
    }
}
exports.default = DeviceEntity;
//# sourceMappingURL=device.entity.js.map