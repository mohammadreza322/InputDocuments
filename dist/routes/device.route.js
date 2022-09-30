"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deviceRouter = void 0;
const express_1 = __importDefault(require("express"));
const device_controller_1 = require("../controller/device.controller");
const authorization_1 = require("../middleware/authorization");
const router = express_1.default.Router();
exports.deviceRouter = router;
router.use([authorization_1.getAuthorization, authorization_1.hasPermission]);
router.post('/save', device_controller_1.saveDevice);
router.post('/delete', device_controller_1.deleteDevice);
router.post('/schedule', device_controller_1.saveSchedule);
router.post('/delete-schedule', device_controller_1.deleteSchedule);
