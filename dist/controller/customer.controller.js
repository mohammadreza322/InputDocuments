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
exports.editUser = exports.deleteCustomer = void 0;
const token_entity_1 = __importDefault(require("../entities/token.entity"));
const device_entity_1 = __importDefault(require("../entities/device.entity"));
const mongoose_1 = require("mongoose");
const user_entity_1 = __importDefault(require("../entities/user.entity"));
const logs_entity_1 = __importDefault(require("../entities/logs.entity"));
const deleteCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.body;
        if (!id) {
            return res.json({ status: false, message: 'خطا در ورودی' });
        }
        if (id.toString().trim() == '') {
            return res.json({ status: false, message: 'خطا در ورودی' });
        }
        const _id = new mongoose_1.Types.ObjectId(id);
        const user = yield user_entity_1.default.getUserInformation(new mongoose_1.Types.ObjectId(_id));
        if (!user) {
            return res.json({ status: false, message: 'خطا در ورودی' });
        }
        yield logs_entity_1.default.removeCustomer(user.fullName, req.user.id);
        yield token_entity_1.default.removeAllUserTokens(_id);
        yield device_entity_1.default.removeAllDeviceOfUser(_id);
        yield user_entity_1.default.removeUser(_id);
        return res.json({ status: true, message: 'حذف کاربر با موفقیت انجام شد' });
    }
    catch (err) {
        console.error('inside remove user');
        console.error(err);
        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
});
exports.deleteCustomer = deleteCustomer;
const editUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id, fullName, phoneNumber, address, birthday } = req.body;
        if (!id || !fullName || !phoneNumber) {
            return res.json({ status: false, message: 'خطا در ورودی' });
        }
        if (id.toString().trim() == '') {
            return res.json({ status: false, message: 'خطا در ورودی' });
        }
        if (!(0, mongoose_1.isValidObjectId)(id)) {
            return res.json({ status: false, message: 'خطا در ورودی' });
        }
        if (fullName.toString().trim() == '') {
            return res.json({ status: false, message: 'نام و نام خانوادگی را وارد کنید' });
        }
        if (phoneNumber.toString().trim() == '') {
            return res.json({ status: false, message: 'شماره تماس را وارد کنید' });
        }
        const data = {
            id, fullName, phoneNumber
        };
        if (address) {
            data['address'] = address;
        }
        if (birthday) {
            data['birthday'] = birthday;
        }
        const user = yield user_entity_1.default.getUserInformation(new mongoose_1.Types.ObjectId(id));
        if (!user) {
            return res.json({ status: false, message: 'خطا در ورودی' });
        }
        if (yield user_entity_1.default.checkPhoneNumberWithId(new mongoose_1.Types.ObjectId(id), phoneNumber)) {
            return res.json({ status: false, message: 'شماره تماس وارد شده مربوط به کاربر دیگری میباشد' });
        }
        if (user.phoneNumber != phoneNumber) {
            yield logs_entity_1.default.changeUserPhoneNumber(user.phoneNumber, phoneNumber, user.fullName, req.user.id);
        }
        yield user_entity_1.default.setUserDetailsWithPhoneNUmber(new mongoose_1.Types.ObjectId(id), fullName, phoneNumber, birthday, address);
        return res.json({ status: true, message: 'اطلاعات کاربر با موفقیت تغییر کرد' });
    }
    catch (err) {
        console.error('inside remove user');
        console.error(err);
        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
});
exports.editUser = editUser;
