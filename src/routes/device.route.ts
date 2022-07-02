import express from 'express';
import { deleteDevice, saveDevice } from '../controller/device.controller';

import { getAuthorization, hasPermission } from '../middleware/authorization';

const router = express.Router();

router.use([getAuthorization, hasPermission]);

router.post('/save', saveDevice);

router.post('/delete', deleteDevice);

export { router as deviceRouter };
