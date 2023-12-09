import express, { Request, Response } from 'express';
import {authRoute} from "./auth.router";
import {dashboardPage} from "../page_view/dashboard.pageview";
import {hasPermissionDashboard} from "../middleware/authorization";
import {customerRoute} from "./customer";
import {adminRoute} from "./admin";
import {deviceSiteRouter} from "./devices.site_router";
import {storeHouse} from "../page_view/devices.pageview";
import {addDevice, deleteDevice, deleteDeviceInStoreRoom} from "../controller/device.controller";
const router = express.Router();


router.get('/',storeHouse)
router.post('/add',addDevice)
router.post('/delete',deleteDeviceInStoreRoom)

export { router as storeRoomRoute };