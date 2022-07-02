import express from 'express';

import {
	editUserProfile,
	getFullName,
	getUserDetails,
} from '../controller/user.controller';
import { getAuthorization, hasPermission } from '../middleware/authorization';

const router = express.Router();

router.use([getAuthorization, hasPermission]);

router.post('/get-name', getFullName);
router.put('/edit', editUserProfile);
router.get('/', getUserDetails);

export { router as userRouter };
