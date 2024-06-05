import express from 'express';
import { getMobile, checkOtp } from '../controller/login.controller';

const router = express.Router();

router.post('/get-mobile', getMobile);

router.post('/check-otp', checkOtp);

export { router as loginRouter };
