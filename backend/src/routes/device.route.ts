import express from 'express';
import {
	saveSchedule,
	deleteDevice,
	saveDevice,
	deleteSchedule,
} from '../controller/device.controller';

import { getAuthorization, hasPermission } from '../middleware/authorization';

const router = express.Router();

router.use([getAuthorization, hasPermission]);

router.post('/save', saveDevice);

router.post('/delete', deleteDevice);

router.post('/schedule', saveSchedule);

router.post('/delete-schedule', deleteSchedule);

export { router as deviceRouter };
