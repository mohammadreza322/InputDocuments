import {Request, Response} from 'express';
import {
    getMobileInput,
    checkOtpInput,
    checkOtpOutput,
} from '../types/login.type';
import isMobilePhone from 'validator/lib/isMobilePhone';
import LoginEntity from '../entities/login.entity';
import SmsProvider from '../classes/sms_provider';
import TokenEntity, {generateTokenOutput} from '../entities/token.entity';
import UserEntity from '../entities/user.entity';
import {CustomRequest} from "../types/global.type";
import LogsEntity from "../entities/logs.entity";

export const getMobile = async (req: CustomRequest, res: Response) => {
    const {phoneNumber}: getMobileInput = req.body;

    // console.log(req.body)

    if (!phoneNumber) {
        return res
            .status(404)
            .json({message: 'شماره تلفن خود را وارد کنید!'});
    }

    if (phoneNumber.trim() === '') {
        return res
            .status(404)
            .json({message: 'شماره تلفن خود را وارد کنید!'});
    }

    if (!isMobilePhone(phoneNumber, 'fa-IR')) {
        return res
            .status(404)
            .json({message: 'شماره تلفن وارد شده اشتباه است!'});
    }

    const loginOutput = await LoginEntity.getCode(phoneNumber);

    if (loginOutput?.id) {
        await SmsProvider.sendOTPCode(loginOutput.code!.toString(),phoneNumber);


        console.log(loginOutput.code)

        req.session.loginId = loginOutput.id.toString()
        req.session.loginCode = loginOutput.code.toString()
        req.session.userPhone = phoneNumber


        return res.json({
            message: 'پیامک با موفقیت ارسال شد',
            id: loginOutput.id,
            isNewUser: loginOutput.isNewUser,
            code: loginOutput.code,
            status: true
        });
    }

    return res.status(400).json({message: loginOutput?.message, status: false});
};

export const checkOtp = async (req: Request, res: Response) => {
    try {
        const {smsId, code, isDashboard}: checkOtpInput = req.body;

        if (isDashboard) {
            if (req.session.isUserLoggedIn) {
                return res.redirect('/dashboard')
            }

            if (!req.session.loginCode) {
                return res.redirect('/dashboard/auth')
            }
        }

        const userAgent = req.get('user-agent');

        if (!userAgent) {
            return res.status(400).json({message: 'ورودی نامعتبر!'});
        }

        if (!smsId || !code) {
            return res.status(404).json({message: 'خطا در ورودی'});
        }

        if (smsId.trim() === '') {
            return res.status(404).json({message: 'خطا در ورودی'});
        }

        if (code.trim() === '') {
            return res.status(404).json({message: 'کد وارد شده اشتباه است'});
        }

        const otpDetails: checkOtpOutput = await LoginEntity.checkOtp(
            smsId,
            code,
        );

        if (otpDetails.message) {
            return res.status(404).json({message: otpDetails.message});
        }

        if (isDashboard) {
        	if(!(await UserEntity.isUserCanLoginInDashboard(otpDetails.userId))){
				return res.json({
					message: 'شما دسترسی به این قسمت ندارید',
					status:false
				});
			}
            await LogsEntity.loginAdmin( otpDetails.userId)

            req.session.isUserLoggedIn = true;

            return res.json({
                message: 'ورود موفقیت آمیز',
				status:true
            });
        }

        const tokens: generateTokenOutput = await TokenEntity.createToken(
            otpDetails.userId!,
            userAgent,
        );
        // console.log("********")

        const brokerDetails = await UserEntity.getBrokerUserNamePassword(
            otpDetails.userId!,
        );

        return res.json({
            message: 'ورود موفقیت آمیز',
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
            details: brokerDetails,
			status:true
        });


    } catch (error) {
        console.error('inside check otp');
        console.error(error);
        return res.status(500).json({message: 'خطایی پیش آمده!!'});
    }
};
