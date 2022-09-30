"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.loginRouter = void 0;
const express_1 = __importDefault(require("express"));
const login_controller_1 = require("../controller/login.controller");
const router = express_1.default.Router();
exports.loginRouter = router;
router.post('/get-mobile', login_controller_1.getMobile);
router.post('/check-otp', login_controller_1.checkOtp);
