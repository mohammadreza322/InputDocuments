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
exports.hasPermission = exports.getAuthorization = void 0;
// import type { CustomRequest } from '../types/global.type';
const permission_model_1 = __importDefault(require("../models/permission.model"));
const isJWT_1 = __importDefault(require("validator/lib/isJWT"));
const tokens_model_1 = __importDefault(require("../models/tokens.model"));
const constants_1 = require("../utility/constants");
const users_model_1 = __importDefault(require("../models/users.model"));
const jwt = require('jsonwebtoken');
const getAuthorization = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const userToken = req.header('x-auth-token');
    try {
        if (!userToken) {
            return res.status(401).json({ message: 'Token is not valid!1' });
        }
        if (!(0, isJWT_1.default)(userToken)) {
            return res.status(401).json({ message: 'Token is not valid!2' });
        }
        const token = yield tokens_model_1.default.findOne({ token: userToken });
        if (!token) {
            return res.status(401).json({ message: 'Token is not valid3' });
        }
        const decoded = jwt.verify(userToken, constants_1.jsonWebTokenSecretKey);
        const user = yield users_model_1.default.findById(decoded.id);
        if (!user) {
            return res.status(403).json({ message: 'Token is not valid!6' });
        }
        req.userDetails = user;
        req.userId = user._id;
        return next();
    }
    catch (err) {
        console.error('authorization error');
        console.error(err);
        return res.status(401).json({ message: 'Token is not valid!7' });
    }
});
exports.getAuthorization = getAuthorization;
const hasPermission = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { userDetails } = req;
        if (!userDetails) {
            return res.status(404).json({ message: 'permission denied' });
        }
        let path = null;
        if (req.path.charAt(0) === '/') {
            path = req.baseUrl + req.path;
        }
        else {
            path = `${req.baseUrl}/${req.path}`;
        }
        const method = req.method;
        if (path[path.length - 1] === '/') {
            path = path.substring(0, path.length - 1);
        }
        const permissions = yield permission_model_1.default.findOne({
            role: userDetails.role,
        });
        const hasPermission = permissions === null || permissions === void 0 ? void 0 : permissions.get(method.toUpperCase()).find((permission) => {
            const permissionRegex = new RegExp(permission);
            return permissionRegex.test(path);
        });
        if (!hasPermission) {
            return res.status(404).json({ message: 'permission denied' });
        }
        return next();
    }
    catch (e) {
        console.error('inside permission middle  ware');
        console.error(e);
        return res.status(500).json({ message: 'خطایی پیش آمده!' });
    }
});
exports.hasPermission = hasPermission;
//# sourceMappingURL=authorization.js.map