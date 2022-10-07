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
const jsonwebtoken_1 = require("jsonwebtoken");
const broker_provider_1 = __importDefault(require("../classes/broker_provider"));
const users_model_1 = __importDefault(require("../models/users.model"));
const constants_1 = require("../utility/constants");
const crypto_js_1 = require("crypto-js");
const device_entity_1 = __importDefault(require("./device.entity"));
const persian_date_1 = __importDefault(require("@alireza-ab/persian-date"));
const convert_1 = require("../classes/convert");
const logs_entity_1 = __importDefault(require("./logs.entity"));
class UserEntity {
    static setUserDetails(id, fullName, birthday, address) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                yield users_model_1.default.updateOne({ _id: id }, {
                    $set: {
                        fullName,
                        birthday,
                        address,
                    },
                });
                return true;
            }
            catch (error) {
                console.error('inside user entity set user details');
                console.error(error);
                return false;
            }
        });
    }
    static setUserDetailsWithPhoneNUmber(id, fullName, phone, birthday, address) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                yield users_model_1.default.updateOne({ _id: id }, {
                    $set: {
                        fullName,
                        birthday,
                        address,
                        phoneNumber: phone
                    },
                });
                return true;
            }
            catch (error) {
                console.error('inside user entity set user details');
                console.error(error);
                return false;
            }
        });
    }
    static getBrokerUserNamePassword(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield users_model_1.default.findOne({ _id: id });
            const usernameBroker = (0, crypto_js_1.SHA1)(user.registerDate.toString() + user._id.toString()).toString();
            const passwordBroker = (0, crypto_js_1.SHA1)(user.registerDate.toString() + (user === null || user === void 0 ? void 0 : user.phoneNumber.toString())).toString();
            const checkUserExists = yield broker_provider_1.default.userExist(usernameBroker);
            console.log(checkUserExists);
            if (!checkUserExists) {
                console.log("add user mnesia");
                yield broker_provider_1.default.addUserToMnesia(usernameBroker, passwordBroker);
            }
            return (0, jsonwebtoken_1.sign)({
                usernameBroker,
                passwordBroker,
            }, constants_1.jsonWebTokenSecretKey, {
                expiresIn: '5m',
            });
        });
    }
    static getUserInformation(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield users_model_1.default.findById(id);
            if (!user) {
                return null;
            }
            let birthday = null;
            if (user.birthday) {
                birthday = Math.ceil(user.birthday.getTime() / 1000);
            }
            return {
                phoneNumber: user.phoneNumber,
                fullName: user.fullName,
                address: user.address,
                birthday: birthday,
            };
        });
    }
    static getUserInformationWithPhoneNumber(phone) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield users_model_1.default.findOne({ phoneNumber: phone });
            let birthday = null;
            if (user.birthday) {
                birthday = Math.ceil(user.birthday.getTime() / 1000);
            }
            return {
                phoneNumber: user.phoneNumber,
                fullName: user.fullName,
                address: user.address,
                birthday: birthday,
                role: user.role,
                id: user.id,
                registerDate: user.registerDate
            };
        });
    }
    static isUserCanLoginInDashboard(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield users_model_1.default.findById(id);
            if (!user) {
                return false;
            }
            if (user.role == 'user') {
                return false;
            }
            if (!user.enable) {
                return false;
            }
            return true;
        });
    }
    static getLastCustomers() {
        return __awaiter(this, void 0, void 0, function* () {
            const users = yield users_model_1.default.find({ role: 'user' })
                .sort({ registerDate: -1 })
                .limit(10);
            const output = [];
            for (const user of users) {
                const countDevices = yield device_entity_1.default.getAllDevicesCount(user._id);
                const userJalaliPersianDate = new persian_date_1.default(user.registerDate).calendar('jalali').toString();
                user.address = user.address ? user.address.trim().length > 0 ? user.address.trim() : 'ندارد' : 'ندارد';
                const userJalaliBirthday = !user.birthday ? 'ندارد' : new persian_date_1.default(`${user.birthday.getFullYear()}-${user.birthday.getMonth() + 1}-${user.birthday.getDate()}`).calendar('jalali').toString();
                if (countDevices > 0) {
                    output.push(Object.assign(Object.assign({}, user.toObject()), { countDevices, jalaliRegisterDate: userJalaliPersianDate, userJalaliBirthday }));
                }
            }
            return output;
        });
    }
    static removeUser(id) {
        return __awaiter(this, void 0, void 0, function* () {
            yield users_model_1.default.deleteOne({ _id: id });
        });
    }
    static getCountAllAdmins() {
        return __awaiter(this, void 0, void 0, function* () {
            const adminsCount = (yield users_model_1.default.countDocuments({ role: 'admin' })) || 0;
            const wareHouseCount = (yield users_model_1.default.countDocuments({ role: 'warehouse' })) || 0;
            const customerServiceCount = (yield users_model_1.default.countDocuments({ role: 'customer_service' })) || 0;
            return adminsCount + wareHouseCount + customerServiceCount;
        });
    }
    static getCountAllClients() {
        return __awaiter(this, void 0, void 0, function* () {
            return (yield users_model_1.default.countDocuments({ role: 'user', fullName: { $ne: null } })) || 0;
        });
    }
    static addAdmin(fullName, phoneNumber, access, enable) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield users_model_1.default.insertMany([{ fullName, phoneNumber, role: access, enable: enable == 'enable' }]);
        });
    }
    static checkPhoneNumberWithId(id, phoneNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            return (yield users_model_1.default.countDocuments({ phoneNumber, _id: { $ne: id } })) > 0;
        });
    }
    static checkPhoneNumberExists(phoneNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            return (yield users_model_1.default.countDocuments({ phoneNumber })) > 0;
        });
    }
    static getAllAdmins(page, limit) {
        return __awaiter(this, void 0, void 0, function* () {
            const admins = yield users_model_1.default
                .find({ $or: [{ role: 'admin' }, { role: 'warehouse' }, { role: 'customer_service' }] }, { fullName: 1, phoneNumber: 1, _id: 1, registerDate: 1, role: 1, enable: 1 })
                .sort({ registerDate: -1 })
                .skip(limit * (page - 1))
                .limit(limit);
            const output = [];
            for (const admin of admins) {
                // console.log(admin.registerDate)
                const userJalaliPersianDate = new persian_date_1.default(admin.registerDate).calendar('jalali').toString();
                const logsDetails = yield logs_entity_1.default.getLogs(admin._id);
                const logs = logsDetails.map(log => {
                    const date = new persian_date_1.default(`${log.date.getFullYear()}-${log.date.getMonth() + 1}-${log.date.getDate()} ${log.date.getHours()}:${log.date.getMinutes()}`).calendar('jalali');
                    return {
                        message: log.message,
                        date: date.toString('datetime')
                    };
                });
                output.push({
                    fullName: admin.fullName,
                    phoneNumber: admin.phoneNumber,
                    registerDate: userJalaliPersianDate,
                    access: admin.role,
                    accessTranslate: (0, convert_1.adminRoleTranslate)(admin.role),
                    enable: admin.enable,
                    enableTranslate: admin.enable ? 'فعال' : 'غیرفعال',
                    id: admin._id,
                    logs: JSON.stringify(logs)
                });
            }
            return output;
        });
    }
    static getAllClients(page, limit) {
        return __awaiter(this, void 0, void 0, function* () {
            const clients = yield users_model_1.default
                .find({ role: 'user', fullName: { $ne: null } }, { fullName: 1, phoneNumber: 1, _id: 1, registerDate: 1, address: 1, birthday: 1 })
                .sort({ registerDate: -1 })
                .skip(limit * (page - 1))
                .limit(limit);
            const output = [];
            for (const user of clients) {
                const countDevices = yield device_entity_1.default.getAllDevicesCount(user._id);
                const userJalaliPersianDate = new persian_date_1.default(user.registerDate).calendar('jalali').toString();
                user.address = user.address ? user.address.trim().length > 0 ? user.address.trim() : 'ندارد' : 'ندارد';
                const userJalaliBirthday = !user.birthday ? 'ندارد' : new persian_date_1.default(`${user.birthday.getFullYear()}-${user.birthday.getMonth() + 1}-${user.birthday.getDate()}`).calendar('jalali').toString();
                output.push(Object.assign(Object.assign({}, user.toObject()), { countDevices, jalaliRegisterDate: userJalaliPersianDate, userJalaliBirthday }));
            }
            return output;
        });
    }
    static editAdmin(id, fullName, phoneNumber, access, enable) {
        return __awaiter(this, void 0, void 0, function* () {
            yield users_model_1.default.updateOne({ _id: id }, {
                $set: {
                    fullName,
                    phoneNumber,
                    role: access,
                    enable: enable == 'enable'
                }
            });
        });
    }
    static editCurrentAdmin(id, fullName, phoneNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            yield users_model_1.default.updateOne({ _id: id }, {
                $set: {
                    fullName,
                    phoneNumber,
                }
            });
        });
    }
    static deleteAdmin(id) {
        return __awaiter(this, void 0, void 0, function* () {
            yield users_model_1.default.deleteOne({ _id: id });
            //todo remove logs
        });
    }
}
exports.default = UserEntity;
