import {Request,Response} from 'express'

export const loginPage = async (req:Request,res:Response) => {
    if (req.session.isUserLoggedIn) {
        // console.log(req.session.isUserLoggedIn)
        return res.redirect('/dashboard')
    }

    res.locals.scripts.push('/js/login.js')

    return res.render('auth/main.ejs',{
        title:'ورود به چیسکو',
        page:'login'
    })
}

export const otpPage = async (req:Request,res:Response) => {
    if (req.session.isUserLoggedIn) {
        return res.redirect('/dashboard')
    }

    if(!req.session.userPhone || !req.session.loginCode) {

        return res.redirect('/dashboard/auth')
    }

    res.locals.scripts.push('/js/otp.js')

    return res.render('auth/main.ejs',{
        title:'رمز یکبار مصرف',
        page:'otp',
        phone:req.session.userPhone,
        id:req.session.loginId
    })
}