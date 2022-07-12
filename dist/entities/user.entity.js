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
    static getBrokerUserNamePassword(id) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield users_model_1.default.findOne({ _id: id });
            const usernameBroker = (0, crypto_js_1.SHA1)(user.registerDate.toString() + user._id.toString()).toString();
            const passwordBroker = (0, crypto_js_1.SHA1)(user.registerDate.toString() + (user === null || user === void 0 ? void 0 : user.phoneNumber.toString())).toString();
            const checkUserExists = yield broker_provider_1.default.userExist(usernameBroker);
            if (!checkUserExists) {
                broker_provider_1.default.addUserToMnesia(usernameBroker, passwordBroker);
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
            return {
                phoneNumber: user.phoneNumber,
                fullName: user.fullName,
                address: user.address,
                birthday: user.birthday,
            };
        });
    }
}
exports.default = UserEntity;
//# sourceMappingURL=user.entity.js.map