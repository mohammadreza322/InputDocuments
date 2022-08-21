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
const constants_1 = require("../utility/constants");
const tokens_model_1 = __importDefault(require("../models/tokens.model"));
const jsonwebtoken_1 = require("jsonwebtoken");
class TokenEntity {
    static generateToken(userId) {
        const accessToken = (0, jsonwebtoken_1.sign)({ id: userId }, constants_1.jsonWebTokenSecretKey, {
            expiresIn: constants_1.accessTokenExpireTime,
        });
        const refreshToken = (0, jsonwebtoken_1.sign)({ id: userId }, constants_1.jsonWebTokenSecretKey, {
            expiresIn: constants_1.refreshTokenExpireTime,
        });
        return {
            accessToken,
            refreshToken,
        };
    }
    static createToken(userId, agent) {
        return __awaiter(this, void 0, void 0, function* () {
            const { accessToken, refreshToken } = this.generateToken(userId.toString());
            yield tokens_model_1.default.insertMany({
                token: accessToken,
                refreshToken: refreshToken,
                agent: agent,
                user: userId,
            });
            return {
                accessToken,
                refreshToken,
            };
        });
    }
    static removeOldToken(userId, agent) {
        return __awaiter(this, void 0, void 0, function* () {
            yield tokens_model_1.default.deleteOne({
                agent: agent,
                user: userId,
            });
        });
    }
}
exports.default = TokenEntity;
//# sourceMappingURL=token.entity.js.map