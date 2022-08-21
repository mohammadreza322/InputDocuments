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
exports.refreshToken = exports.editUserProfile = exports.getUserDetails = exports.getFullName = void 0;
const user_entity_1 = __importDefault(require("../entities/user.entity"));
const device_entity_1 = __importDefault(require("../entities/device.entity"));
const validator_1 = __importDefault(require("../classes/validator"));
const constants_1 = require("../utility/constants");
const jwt = require('jsonwebtoken');
const tokens_model_1 = __importDefault(require("../models/tokens.model"));
const moment_1 = __importDefault(require("moment"));
const token_entity_1 = __importDefault(require("../entities/token.entity"));
const getFullName = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { fullName } = req.body;
        if (!fullName) {
            return res.status(400).json({ message: 'ورودی نامعتبر!' });
        }
        if (fullName.trim() === '') {
            return res.status(404).json({ message: 'خطا در ورودی' });
        }
        if (yield user_entity_1.default.setUserDetails(req.userId, fullName, undefined, undefined)) {
            return res.json({ message: 'نام شما با موفقیت ثبت شد' });
        }
        else {
            return res.status(500).json({ message: 'خطایی پیش آمده!!' });
        }
    }
    catch (error) {
        console.error('inside get fullName');
        console.error(error);
        return res.status(500).json({ message: 'خطایی پیش آمده!!' });
    }
});
exports.getFullName = getFullName;
const getUserDetails = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const userDetails = yield user_entity_1.default.getUserInformation(req.userId);
        const userDevices = yield device_entity_1.default.getAllDevices(req.userId);
        return res.json({ user: userDetails, devices: userDevices });
    }
    catch (error) {
        console.error('inside get use details');
        console.error(error);
        return res.status(500).json({ message: 'خطایی پیش آمده!!' });
    }
});
exports.getUserDetails = getUserDetails;
const editUserProfile = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { fullName, address, birthday } = req.body;
        if (!fullName) {
            return res.json({ message: 'خطا در ورودی' });
        }
        if (fullName.trim() === '') {
            return res.json({ message: 'نام خود را وارد نکرده اید!' });
        }
        let userBirthday = undefined;
        if (birthday) {
            if (!validator_1.default.isValidDate(birthday)) {
                return res.json({
                    message: 'تاریخ تولد وارد شده درست نیست!',
                });
            }
            userBirthday = new Date(birthday);
        }
        if (yield user_entity_1.default.setUserDetails(req.userId, fullName, userBirthday, address)) {
            return res.json({ message: 'اطلاعات شما با موفقیت تغییر کرد' });
        }
        else {
            return res.status(500).json({ message: 'خطایی پیش آمده!!' });
        }
    }
    catch (error) {
        console.error('inside edit profile');
        console.error(error);
        return res.status(500).json({ message: 'خطایی پیش آمده!!' });
    }
});
exports.editUserProfile = editUserProfile;
const refreshToken = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { refreshToken } = req.body;
    const userToken = req.header('x-auth-token');
    const userAgent = req.get('user-agent');
    if (!refreshToken || !userToken) {
        return res.status(404).send({ message: 'خطا در شناسایی توکن' });
    }
    if (refreshToken == null || userToken == null) {
        return res.status(404).send({ message: 'خطا در شناسایی توکن' });
    }
    try {
        const decoded = jwt.verify(refreshToken, constants_1.jsonWebTokenSecretKey);
        const token = yield tokens_model_1.default.findOne({ token: userToken });
        if (!token) {
            return res.status(404).json({ message: 'invalid token1' });
        }
        if (refreshToken !== token.refreshToken) {
            return res.status(404).json({ message: 'invalid token2' });
        }
        if (!token.user.equals(decoded.id)) {
            return res.status(401).json({ message: 'Token is not valid' });
        }
        const now = (0, moment_1.default)(new Date());
        const duration = moment_1.default.duration(now.diff(token.time)).asDays();
        if (Math.floor(duration) > 30) {
            return res.status(404).json({ message: 'invalid refresh token!' });
        }
        yield token_entity_1.default.removeOldToken(decoded.id, userAgent);
        const tokens = yield token_entity_1.default.createToken(decoded.id, userAgent);
        return res.json({
            message: 'توکن شما با موفیت تغییر کرد',
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
        });
    }
    catch (e) {
        console.error('inside refresh token');
        console.error(e);
        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
});
exports.refreshToken = refreshToken;
//# sourceMappingURL=user.controller.js.map