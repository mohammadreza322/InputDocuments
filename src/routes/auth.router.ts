import express, { Request, Response } from 'express';

import {loginPage, otpPage} from "../page_view/auth.pageview";
import {checkOtp, getMobile} from "../controller/login.controller";
const router = express.Router();

router.get('/',loginPage)
router.get('/otp',otpPage)

router.post('/get-mobile',getMobile)
router.post('/check-otp',checkOtp)

export { router as authRoute };