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
const sms_codes_1 = __importDefault(require("../models/sms_codes"));
const moment_1 = __importDefault(require("moment"));
const users_model_1 = __importDefault(require("../models/users.model"));
class LoginEntity {
    static getCode(phoneNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            const output = {
                message: '',
                id: undefined,
                code: -1,
                isNewUser: true,
            };
            try {
                const smsCode = yield sms_codes_1.default.findOne({ phoneNumber }).sort({
                    date: -1,
                });
                if (smsCode) {
                    const now = (0, moment_1.default)(new Date());
                    const duration = moment_1.default
                        .duration(now.diff(smsCode.date))
                        .asMinutes();
                    if (Math.floor(duration) < 2) {
                        output.message =
                            'شما در 2 دقیقه گذشته یک بار درخواست داده اید';
                        return output;
                    }
                }
                // const code = this.generateCode();
                // console.log(code)
                const code = 12345;
                const newSmsCode = new sms_codes_1.default({ phoneNumber, code });
                yield newSmsCode.save();
                const userDetails = yield users_model_1.default.findOne({
                    phoneNumber: newSmsCode.phoneNumber,
                });
                if (userDetails) {
                    if (userDetails.fullName) {
                        output.isNewUser = false;
                    }
                }
                output.code = code;
                output.id = newSmsCode._id;
                return output;
            }
            catch (e) {
                console.error('inside get code login');
                console.error(e);
                output.message = 'خطایی پیش آمده!';
            }
        });
    }
    static generateCode() {
        const min = 10000;
        const max = 90000;
        return Math.floor(min + Math.random() * max);
    }
    static checkOtp(smsId, code) {
        return __awaiter(this, void 0, void 0, function* () {
            const smsCode = yield sms_codes_1.default.findById(smsId);
            const output = {};
            if (!smsCode) {
                output.message = 'کد مورد نظر یافت نشد!';
                return output;
            }
            if (smsCode.code !== code) {
                output.message = 'کد وارد شده اشتباه است!';
                return output;
            }
            const now = (0, moment_1.default)(new Date());
            const duration = moment_1.default.duration(now.diff(smsCode.date)).asMinutes();
            if (duration > 2) {
                output.message = 'کد شما منقضی شده است لطفا دوباره درخواست بدهید!';
                return output;
            }
            const userDetails = yield users_model_1.default.findOne({
                phoneNumber: smsCode.phoneNumber,
            });
            let userId = null;
            let registerDate = null;
            const phoneNumber = smsCode.phoneNumber;
            if (!userDetails) {
                const user = new users_model_1.default({
                    phoneNumber: phoneNumber,
                });
                yield user.save();
                userId = user._id;
                registerDate = user.registerDate;
            }
            else {
                userId = userDetails._id;
                registerDate = userDetails.registerDate;
            }
            yield sms_codes_1.default.findByIdAndDelete(smsCode._id);
            output.userId = userId;
            return output;
        });
    }
}
exports.default = LoginEntity;
