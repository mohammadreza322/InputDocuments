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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const axios_1 = __importDefault(require("axios"));
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
            const response = yield axios_1.default
                .post(`${constants_1.brokerUrlAPI}/api/v4/auth_username`, {
                username: encodeURIComponent(username),
                password: encodeURIComponent(password),
            }, this._config)
                .catch((e) => {
                console.error('error in add user mnesia response');
                console.error(e);
            });
            return response;
        });
    }
    static userExist(username) {
        return __awaiter(this, void 0, void 0, function* () {
            const response = yield axios_1.default
                .get(`${constants_1.brokerUrlAPI}/api/v4/auth_username/${username}`, this._config)
                .catch((e) => {
                console.error('error in exists user mnesia response');
                console.error(e);
            });
            if (response) {
                return Object.keys(response.data.data).length !== 0;
            }
            return false;
        });
    }
}
exports.default = BrokerProvider;
BrokerProvider._config = {
    auth: {
        username: '20bf501bc0fa6',
        password: 'MzA1NTY2NTE4NzM5MTk5NzY5MDAyNTEwNzM2NDA1OTU0NTG',
    },
};
//# sourceMappingURL=broker_provider.js.map