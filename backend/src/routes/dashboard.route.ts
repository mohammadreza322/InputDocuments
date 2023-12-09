import express, { Request, Response } from 'express';
import {authRoute} from "./auth.router";
import {dashboardPage, exitAdmin} from "../page_view/dashboard.pageview";
import {hasPermissionDashboard} from "../middleware/authorization";
import {customerRoute} from "./customer";
import {adminRoute} from "./admin";
import {deviceSiteRouter} from "./devices.site_router";
import {storeRoomRoute} from "./store_room.route";
const router = express.Router();

router.use('/auth',authRoute)
router.get('/exit',exitAdmin)

router.use(hasPermissionDashboard)

router.use('/client',customerRoute)
router.use('/admin',adminRoute)
router.use('/devices',deviceSiteRouter)
router.use('/store_room',storeRoomRoute)

router.get('/',dashboardPage)

export { router as dashboardRoute };