"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authRoute = void 0;
const express_1 = __importDefault(require("express"));
const auth_pageview_1 = require("../page_view/auth.pageview");
const router = express_1.default.Router();
exports.authRoute = router;
router.get('/', auth_pageview_1.loginPage);
router.get('/otp', auth_pageview_1.otpPage);
