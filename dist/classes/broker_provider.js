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
                'url': 'http://185.204.197.144:8081/api/v4/auth_username',
                'headers': {
                    'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw==',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    "username": username,
                    "password": password
                })
            };
            return yield request(options, function (error, response) {
                if (error) {
                    console.error('inside add mnesia user');
                    console.error(error);
                    return false;
                }
                return true;
            });
        });
    }
    static userExist(username) {
        return __awaiter(this, void 0, void 0, function* () {
            const options = {
                'method': 'GET',
                'url': `http://185.204.197.144:8081/api/v4/auth_username/${username}`,
                'headers': {
                    'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw=='
                }
            };
            return yield request(options, function (error, response) {
                if (error) {
                    console.error('inside check mnesia user');
                    console.error(error);
                    return false;
                }
                return true;
            });
        });
    }
    static kickDevice(serialNumber) {
        return __awaiter(this, void 0, void 0, function* () {
            const options = {
                'method': 'GET',
                'url': `http://185.204.197.144:8081/api/v4/clients/${serialNumber}`,
                'headers': {
                    'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw=='
                }
            };
            return yield request(options, function (error, response) {
                if (error) {
                    console.error('inside check kick mnesia');
                    console.error(error);
                    return false;
                }
                return true;
            });
        });
    }
}
exports.default = BrokerProvider;
BrokerProvider.username = '20bf501bc0fa6';
BrokerProvider.pass = 'MzA1NTY2NTE4NzM5MTk5NzY5MDAyNTEwNzM2NDA1OTU0NTG';
