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
const logs_1 = __importDefault(require("../models/logs"));
const device_entity_1 = __importDefault(require("./device.entity"));
class LogsEntity {
    static changeUserPhoneNumber(oldPhone, newPhone, userFullName, adminId) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.addLog(`تغییر شماره تلفن کاربر “${userFullName}” از ${oldPhone} به ${newPhone}.`, adminId);
        });
    }
    static removeCustomer(userFullName, adminId) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.addLog(`حذف کردن کاربر “${userFullName}” از لیست کاربران.`, adminId);
        });
    }
    static addDevicePower(serialNumber, adminId, deviceId) {
        return __awaiter(this, void 0, void 0, function* () {
            // await this.addLog('ورود اولیه به سیستم.',deviceId);
            return yield this.addLog(`اضافه کردن دستگاه سه راهه با شماره سریال “${serialNumber}”.`, adminId);
        });
    }
    static addDeviceCooler(serialNumber, adminId, deviceId) {
        return __awaiter(this, void 0, void 0, function* () {
            // await this.addLog('ورود اولیه به سیستم.',deviceId);
            return yield this.addLog(`اضافه کردن دستگاه کولر با شماره سریال “${serialNumber}”.`, adminId);
        });
    }
    static kickDeviceFromBroker(serialNumber, adminId, adminName) {
        return __awaiter(this, void 0, void 0, function* () {
            const id = yield device_entity_1.default.getIdOfDevice(serialNumber);
            yield this.addLog(`حذف از بروکر توسط مدیر “${adminName}”.`, id);
            return yield this.addLog(`حذف دستگاه “${serialNumber}” از بروکر.`, adminId);
        });
    }
    static loginAdmin(adminId) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.addLog(`ورود به سیستم.`, adminId);
        });
    }
    static deviceReconnectToServer(serialNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            const id = yield device_entity_1.default.getIdOfDevice(serialNumber);
            if (id) {
                return yield this.addLog('اتصال مجدد به سیستم.', id);
            }
        });
    }
    static deviceDisconnectToServer(serialNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            const id = yield device_entity_1.default.getIdOfDevice(serialNumber);
            if (id) {
                return yield this.addLog('قطع ارتباط با سیستم.', id);
            }
        });
    }
    static getLogs(logId) {
        return __awaiter(this, void 0, void 0, function* () {
            return logs_1.default.find({ logId }).sort({ 'date': -1 }).limit(5);
        });
    }
    static addLog(message, logId) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield logs_1.default.insertMany([{
                    message: message,
                    logId
                }]);
        });
    }
}
exports.default = LogsEntity;
