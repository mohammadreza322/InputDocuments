"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deviceSiteRouter = void 0;
const express_1 = __importDefault(require("express"));
const devices_pageview_1 = require("../page_view/devices.pageview");
const device_controller_1 = require("../controller/device.controller");
const router = express_1.default.Router();
exports.deviceSiteRouter = router;
router.post('/delete', device_controller_1.deleteOwnerOfDevice);
router.post('/kick', device_controller_1.kickDevice);
router.get('/', devices_pageview_1.devicesPage);
