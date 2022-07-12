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
/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * class that manage send sms to users
 * @type {SmsProvider}
 */
const axios_1 = __importDefault(require("axios"));
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
class SmsProvider {
    constructor(mobilePhone) {
        this._apiKey = 'nc7wjMYbZbHhWmDi8fo-6RllrpqrDC1w_6fGJ1j5eUY= ';
        this._smsNumber = '+983000505';
        this._url = 'http://ippanel.com:8080/';
        this._moblePhone = mobilePhone;
    }
    /**
     * @description
     * this method send verification code to user for authorization
     * @param code
     * @param lang
     * @returns {Promise<boolean>}
     */
    sendAuthSms(code) {
        //todo fix pattern id with language
        const patternId = '8n8fto5aq9';
        const patternKey = 'verification-code';
        //send sms code to user
        return this._sendWithPattern(patternId, [patternKey], [code]);
    }
    /**
     * @description
     * this method manage send sms process to sms provider host
     * @async
     * @param patternValues
     *
     * if use patterns we can set pattern id and pattern values
     * @param patternId
     * @param patternKey
     * @returns {Promise<boolean>}
     * @private
     */
    _sendWithPattern(patternId, patternKey = ['%name'], patternValues = ['آرش']) {
        return __awaiter(this, void 0, void 0, function* () {
            const params = new URLSearchParams([
                ['apikey', this._apiKey],
                ['fnum', this._smsNumber],
                ['tnum', this._moblePhone],
            ]);
            if (patternId) {
                params.append('pid', patternId);
            }
            patternKey.forEach((value, index) => {
                params.append(`p${index + 1}`, value);
            });
            patternValues.forEach((value, index) => {
                params.append(`v${index + 1}`, value);
            });
            const response = yield axios_1.default.get(this._url, { params });
            //todo add log function
            if (response.status > 400) {
                fs_1.default.writeFile(path_1.default.join(__dirname, '..', 'logs/sms_errors.txt'), JSON.stringify(response), (err) => {
                    if (err) {
                        console.error(err);
                    }
                });
            }
            console.log('response status');
            console.log(response.status);
            console.log(response.data);
            return response.status === 200 || response.status === 201;
        });
    }
}
exports.default = SmsProvider;
//# sourceMappingURL=sms_provider.js.map