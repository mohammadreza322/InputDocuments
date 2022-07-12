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
exports.deleteSchedule = exports.saveSchedule = exports.deleteDevice = exports.saveDevice = void 0;
const mongoose_1 = require("mongoose");
const validator_1 = __importDefault(require("../classes/validator"));
const device_entity_1 = __importDefault(require("../entities/device.entity"));
const saveDevice = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { serialNumber, name, category } = req.body;
        if (!serialNumber || !name || !category) {
            return res.status(400).json({ message: 'خطا در ورودی1' });
        }
        if (serialNumber.trim() === '') {
            return res.status(400).json({ message: 'خطا در ورودی2' });
        }
        if (category.trim() === '') {
            return res.status(400).json({ message: 'خطا در ورودی3' });
        }
        if (name.trim() === '') {
            return res.status(400).json({ message: 'خطا در ورودی4' });
        }
        const validateSerialNumber = yield device_entity_1.default.validateSerialNumber(serialNumber.trim(), req.userId, 'save');
        if (!validateSerialNumber.valid) {
            return res
                .status(400)
                .json({ message: validateSerialNumber.message });
        }
        if (validateSerialNumber.type == 'cooler') {
            const { brand, model } = req.body;
            if (!brand || !model) {
                return res.status(400).json({ message: 'خطا در ورودی5' });
            }
            if (brand.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'برند کولر را وارد نکرده اید' });
            }
            if (model.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'مدل کولر را وارد نکرده اید' });
            }
            //todo check validate brand and model
            yield device_entity_1.default.saveCooler(serialNumber.trim(), brand.trim(), model.trim(), name.trim(), category.trim(), req.userId);
        }
        else if (validateSerialNumber.type == 'power') {
            const { power1, power2, power3, power4, usb1, usb2, } = req.body;
            if (!power1 || !power2 || !power3 || !power4 || !usb1 || !usb2) {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
            if (power1.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'نام پریز 1 را وارد نکرده اید!' });
            }
            if (power2.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'نام پریز 2 را وارد نکرده اید!' });
            }
            if (power3.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'نام پریز 3 را وارد نکرده اید!' });
            }
            if (power4.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'نام پریز 4 را وارد نکرده اید!' });
            }
            if (usb1.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'نام پورت 1 را وارد نکرده اید!' });
            }
            if (usb2.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'نام پورت 2 را وارد نکرده اید!' });
            }
            yield device_entity_1.default.savePower(serialNumber.trim(), category.trim(), name.trim(), req.userId, power1.trim(), power2.trim(), power3.trim(), power4.trim(), usb1.trim(), usb2.trim());
        }
        const devices = yield device_entity_1.default.getAllDevices(req.userId);
        return res.json({ message: 'دستگاه شما با موفقیت ذخیره شد', devices });
    }
    catch (err) {
        console.error('inside add device');
        console.error(err);
        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
});
exports.saveDevice = saveDevice;
const deleteDevice = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { serialNumber } = req.body;
        if (!serialNumber) {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        const validateSerialNumber = yield device_entity_1.default.validateSerialNumber(serialNumber, req.userId, 'delete');
        if (!validateSerialNumber.valid) {
            return res
                .status(400)
                .json({ message: validateSerialNumber.message });
        }
        yield device_entity_1.default.deleteOwnerDevice(serialNumber, validateSerialNumber.type);
        const devices = yield device_entity_1.default.getAllDevices(req.userId);
        return res.json({ message: 'دستگاه شما با موفقیت حذف شد', devices });
    }
    catch (err) {
        console.error('inside delete device');
        console.error(err);
        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
});
exports.deleteDevice = deleteDevice;
const saveSchedule = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { startTime, endTime, repeat, serialNumber, portNumber, id, enable, } = req.body;
        if (!startTime && !endTime) {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (!serialNumber || !repeat) {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (serialNumber.trim() === '') {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (!validator_1.default.isWeekDayArray(repeat)) {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (startTime) {
            if (!validator_1.default.isTime(startTime)) {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
        }
        if (endTime) {
            if (!validator_1.default.isTime(endTime)) {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
        }
        const validateSerialNumber = yield device_entity_1.default.validateSerialNumber(serialNumber, req.userId, 'addSchedule');
        if (!validateSerialNumber.valid) {
            return res
                .status(500)
                .json({ message: validateSerialNumber.message });
        }
        if (validateSerialNumber.type === 'power') {
            if (!portNumber) {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
        }
        if (!id) {
            yield device_entity_1.default.addSchedule({
                serialNumber: serialNumber.trim(),
                startTime: startTime === null || startTime === void 0 ? void 0 : startTime.trim(),
                endTime: endTime === null || endTime === void 0 ? void 0 : endTime.trim(),
                repeat,
                type: validateSerialNumber.type,
                portNumber,
            });
        }
        else {
            if (enable === undefined || enable == null) {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
            if (typeof enable !== 'boolean') {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
            if (id.trim() === '') {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
            if (!(0, mongoose_1.isValidObjectId)(id)) {
                return res.status(400).json({ message: 'خطا در ورودی' });
            }
            yield device_entity_1.default.editSchedule({
                serialNumber,
                startTime,
                endTime,
                repeat,
                portNumber,
                enable,
                _id: new mongoose_1.Types.ObjectId(id),
                type: validateSerialNumber.type,
            });
        }
        const devices = yield device_entity_1.default.getAllDevices(req.userId);
        return res.json({
            message: 'تغییرات شما با موفقیت ذخیره شد',
            devices,
        });
    }
    catch (err) {
        console.error('inside add schedule');
        console.error(err);
        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
});
exports.saveSchedule = saveSchedule;
const deleteSchedule = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { serialNumber, id } = req.body;
        if (!serialNumber || !id) {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (serialNumber.trim() === '') {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (id.trim() === '') {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        const validateSerialNumber = yield device_entity_1.default.validateSerialNumber(serialNumber, req.userId, 'deleteSchedule');
        if (!validateSerialNumber.valid) {
            return res
                .status(400)
                .json({ message: validateSerialNumber.message });
        }
        yield device_entity_1.default.deleteSchedule(serialNumber, new mongoose_1.Types.ObjectId(id), validateSerialNumber.type);
        const devices = yield device_entity_1.default.getAllDevices(req.userId);
        return res.json({
            message: 'تغییرات شما با موفقیت ذخیره شد',
            devices,
        });
    }
    catch (err) {
        console.error('inside delete schedule');
        console.error(err);
        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
});
exports.deleteSchedule = deleteSchedule;
//# sourceMappingURL=device.controller.js.map