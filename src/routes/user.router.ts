import express from 'express';

import {
	editUserProfile,
	getFullName,
	getUserDetails,
	refreshToken,
} from '../controller/user.controller';
import { getAuthorization, hasPermission } from '../middleware/authorization';

const router = express.Router();

router.put('/refresh-token', refreshToken);

router.use([getAuthorization, hasPermission]);

router.post('/get-name', getFullName);
router.put('/edit', editUserProfile);
router.get('/', getUserDetails);

export { router as userRouter };
