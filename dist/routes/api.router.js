"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.apiRouter = void 0;
const express_1 = __importDefault(require("express"));
const device_route_1 = require("./device.route");
const login_router_1 = require("./login.router");
const user_router_1 = require("./user.router");
const router = express_1.default.Router();
exports.apiRouter = router;
router.use(login_router_1.loginRouter);
router.use('/user', user_router_1.userRouter);
router.use('/device', device_route_1.deviceRouter);
router.get('/', (req, res) => {
    return res.send('server is run');
});
router.use((req, res) => {
    return res.status(404).send('are you lost baby?');
});
