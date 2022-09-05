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
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (serialNumber.trim() === '') {
            return res
                .status(400)
                .json({ message: 'شماره سریال را وارد نکرده اید!' });
        }
        if (category.trim() === '') {
            return res
                .status(400)
                .json({ message: 'دسته بندی را وارد نکرده اید!' });
        }
        if (name.trim() === '') {
            return res
                .status(400)
                .json({ message: 'نام دستگاه را وارد نکرده اید!' });
        }
        const validateSerialNumber = yield device_entity_1.default.validateSerialNumber(serialNumber.trim(), req.userId, 'save');
        if (!validateSerialNumber.valid) {
            return res
                .status(400)
                .json({ message: validateSerialNumber.message });
        }
        if (validateSerialNumber.type == 'cooler') {
            const { model } = req.body;
            if (!model) {
                return res.status(400).json({ message: 'مدل دستگاه را وارد نکرده اید!' });
            }
            // if (brand!.trim() === '') {
            // 	return res
            // 		.status(400)
            // 		.json({ message: 'برند کولر را وارد نکرده اید' });
            // }
            if (model.trim() === '') {
                return res
                    .status(400)
                    .json({ message: 'مدل کولر را وارد نکرده اید!' });
            }
            //todo check validate brand and model
            yield device_entity_1.default.saveCooler(serialNumber.trim(), model.trim(), name.trim(), category.trim(), req.userId);
        }
        else if (validateSerialNumber.type == 'power') {
            let { power1, power2, power3, power4, usb1, usb2 } = req.body;
            // if (power1.toString().trim() == '') {
            // 	power1 = 'پریز 1';
            // }
            // if (power2.toString().trim() == '') {
            // 	power2 = 'پریز 2';
            // }
            // if (power3.toString().trim() == '') {
            // 	power3 = 'پریز 3';
            // }
            // if (power4.toString().trim() == '') {
            // 	power4 = 'پریز 4';
            // }
            // if (usb1.toString().trim() == '') {
            // 	usb1 = 'پورت 1';
            // }
            // if (usb2.toString().trim() == '') {
            // 	usb2 = 'پورت 1';
            // }
            yield device_entity_1.default.savePower(serialNumber.trim(), category.trim(), name.trim(), req.userId, power1, power2, power3, power4, usb1, usb2);
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
            return res.status(400).json({ message: 'خطا در ورودی!' });
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
            return res.status(400).json({ message: 'زمان روشن شدن یا زمان خاموش شدن باید انتخاب شود' });
        }
        if (!serialNumber || !repeat) {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (serialNumber.trim() === '') {
            return res.status(400).json({ message: 'خطا در ورودی' });
        }
        if (!validator_1.default.isWeekDayArray(repeat)) {
            return res.status(400).json({ message: 'فرمت انتخاب روز های هفته اشتباه است' });
        }
        if (startTime) {
            if (!validator_1.default.isTime(startTime)) {
                return res.status(400).json({ message: 'فرمت ساعت روشن شدن اشتباه است' });
            }
        }
        if (endTime) {
            if (!validator_1.default.isTime(endTime)) {
                return res.status(400).json({ message: 'فرمت ساعت خاموش شدن اشتباه است' });
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