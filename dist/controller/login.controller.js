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
exports.checkOtp = exports.getMobile = void 0;
const isMobilePhone_1 = __importDefault(require("validator/lib/isMobilePhone"));
const login_entity_1 = __importDefault(require("../entities/login.entity"));
const token_entity_1 = __importDefault(require("../entities/token.entity"));
const user_entity_1 = __importDefault(require("../entities/user.entity"));
const getMobile = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { phoneNumber } = req.body;
    if (!phoneNumber) {
        return res
            .status(404)
            .json({ message: 'شماره تلفن خود را وارد کنید!' });
    }
    if (phoneNumber.trim() === '') {
        return res
            .status(404)
            .json({ message: 'شماره تلفن خود را وارد کنید!' });
    }
    if (!(0, isMobilePhone_1.default)(phoneNumber, 'fa-IR')) {
        return res
            .status(404)
            .json({ message: 'شماره تلفن وارد شده اشتباه است!' });
    }
    const loginOutput = yield login_entity_1.default.getCode(phoneNumber);
    if (loginOutput === null || loginOutput === void 0 ? void 0 : loginOutput.id) {
        // const smsProvider: SmsProvider = new SmsProvider(phoneNumber);
        // await smsProvider.sendAuthSms(loginOutput.code!.toString());
        return res.json({
            message: 'پیامک با موفقیت ارسال شد',
            id: loginOutput.id,
            isNewUser: loginOutput.isNewUser,
            code: loginOutput.code,
        });
    }
    return res.status(400).json({ message: loginOutput === null || loginOutput === void 0 ? void 0 : loginOutput.message });
});
exports.getMobile = getMobile;
const checkOtp = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { smsId, code } = req.body;
        const userAgent = req.get('user-agent');
        if (!userAgent) {
            return res.status(400).json({ message: 'ورودی نامعتبر!' });
        }
        if (!smsId || !code) {
            return res.status(404).json({ message: 'خطا در ورودی' });
        }
        if (smsId.trim() === '') {
            return res.status(404).json({ message: 'خطا در ورودی' });
        }
        if (code.trim() === '') {
            return res.status(404).json({ message: 'کد وارد شده اشتباه است' });
        }
        const otpDetails = yield login_entity_1.default.checkOtp(smsId, code);
        if (otpDetails.message) {
            return res.status(404).json({ message: otpDetails.message });
        }
        const tokens = yield token_entity_1.default.createToken(otpDetails.userId, userAgent);
        const brokerDetails = yield user_entity_1.default.getBrokerUserNamePassword(otpDetails.userId);
        return res.json({
            message: 'ورود موفقیت آمیز',
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
            details: brokerDetails,
        });
    }
    catch (error) {
        console.error('inside check otp');
        console.error(error);
        return res.status(500).json({ message: 'خطایی پیش آمده!!' });
    }
});
exports.checkOtp = checkOtp;
//# sourceMappingURL=login.controller.js.map