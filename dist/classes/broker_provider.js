"use strict";
/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * this class use for broker apis
 * @type {BrokerProvider}
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
const constants_1 = require("../utility/constants");
class BrokerProvider {
    /**
     * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
     * @description
     * add a user to mnesia authentication
     * @param username
     * @param password
     * @return {Promise<AxiosResponse<any>>}
     */
    static addUserToMnesia(username, password) {
        return __awaiter(this, void 0, void 0, function* () {
            var options = {
                'method': 'POST',
                'url': `${constants_1.brokerUrlAPI}/auth_username`,
                'headers': {
                    'Authorization': this.authorization,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    "username": username,
                    "password": password
                })
            };
            return new Promise((resolve, reject) => {
                request(options, function (error, response) {
                    if (error) {
                        console.error('inside add mnesia user');
                        console.error(error);
                        return resolve(false);
                    }
                    return resolve(true);
                });
            });
        });
    }
    static userExist(username) {
        return __awaiter(this, void 0, void 0, function* () {
            const options = {
                'method': 'GET',
                'url': `${constants_1.brokerUrlAPI}/auth_username/${username}`,
                'headers': {
                    'Authorization': this.authorization
                }
            };
            return new Promise(function (resolve, reject) {
                request(options, function (error, response) {
                    if (error) {
                        console.error('inside check mnesia user');
                        console.error(error);
                        return resolve(false);
                    }
                    console.log(response);
                    const data = JSON.parse(response.body);
                    if (data.data) {
                        if (data.data.username) {
                            return resolve(true);
                        }
                        return resolve(false);
                    }
                    return resolve(false);
                });
            });
        });
    }
    static kickDevice(serialNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            const options = {
                'method': 'GET',
                'url': `${this.authorization}/clients/${serialNumber}`,
                'headers': {
                    'Authorization': this.authorization
                }
            };
            return new Promise((resolve, reject) => {
                request(options, function (error, response) {
                    if (error) {
                        console.error('inside check kick mnesia');
                        console.error(error);
                        return resolve(false);
                    }
                    return resolve(true);
                });
            });
        });
    }
}
exports.default = BrokerProvider;
BrokerProvider.authorization = 'Basic MjBiZjUwMWJjMGZhNjpqRXdzUmdXbU9IQWFQazFCcEMwSWtGNEl2RWxYZ01CNmNzd0VocHYwMnpO';
