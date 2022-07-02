import express from 'express';

import { getFullName, getUserDetails } from '../controller/user.controller';
import { getAuthorization, hasPermission } from '../middleware/authorization';

const router = express.Router();

router.post('/get-name', [getAuthorization, hasPermission], getFullName);
router.get('/', [getAuthorization, hasPermission], getUserDetails);

export { router as userRouter };
