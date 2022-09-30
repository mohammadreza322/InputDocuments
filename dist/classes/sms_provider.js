"use strict";
/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * class that manage send sms to users
 * @type {SmsProvider}
 */
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const request = require('request');
class SmsProvider {
    static sendOTPCode(code, mobileNumber) {
        this.sendSms(mobileNumber, `به چیسکو خوش آمدید\r\nکد ورود:${code}`);
    }
    static checkPanelCredit() {
        return __awaiter(this, void 0, void 0, function* () {
            const options = {
                method: 'POST',
                url: 'https://api.ghasedak.me/v2/account/info',
                headers: {
                    'cache-control': 'no-cache',
                    apikey: this.apiKey,
                    'content-type': 'application/x-www-form-urlencoded'
                },
                form: {}
            };
            return new Promise(function (resolve, reject) {
                request(options, function (error, response, body) {
                    if (error) {
                        console.error('send sms error');
                        console.error(error);
                        return resolve(0);
                        // return;
                    }
                    try {
                        const jsonBody = JSON.parse(body);
                        console.log(jsonBody);
                        return resolve(jsonBody.items.balance);
                    }
                    catch (e) {
                        return resolve(0);
                    }
                    // console.log(body)
                });
            });
        });
    }
    static sendSms(receptor, message) {
        const method = 'POST';
        const options = {
            method,
            url: `${this.url}sms/send/simple`,
            headers: {
                'cache-control': 'no-cache',
                'apikey': this.apiKey,
                'content-type': 'application/x-www-form-urlencoded'
            },
            form: {
                message: message,
                receptor: receptor,
                linenumber: this.smsNumber
            }
        };
        request(options, function (error, response, body) {
            if (error) {
                console.error('send sms error');
                console.error(error);
                return;
            }
            console.log(body);
        });
    }
}
exports.default = SmsProvider;
SmsProvider.apiKey = '77ea86d1fee701d5f493d9d774562cd5648412db622a05c44295a9ed97965d75';
SmsProvider.smsNumber = '10008566';
SmsProvider.url = 'https://api.ghasedak.me/v2/';
