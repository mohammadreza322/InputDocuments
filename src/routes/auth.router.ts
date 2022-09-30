import express, { Request, Response } from 'express';

import {loginPage, otpPage} from "../page_view/auth.pageview";
const router = express.Router();

router.get('/',loginPage)
router.get('/otp',otpPage)

export { router as authRoute };