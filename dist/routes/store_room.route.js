"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.storeRoomRoute = void 0;
const express_1 = __importDefault(require("express"));
const devices_pageview_1 = require("../page_view/devices.pageview");
const device_controller_1 = require("../controller/device.controller");
const router = express_1.default.Router();
exports.storeRoomRoute = router;
router.get('/', devices_pageview_1.storeHouse);
router.post('/add', device_controller_1.addDevice);
router.post('/delete', device_controller_1.deleteDeviceInStoreRoom);
