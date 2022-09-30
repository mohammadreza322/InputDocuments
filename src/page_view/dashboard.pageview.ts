import {Request, Response} from "express";
import DeviceEntity from "../entities/device.entity";
import UserEntity from "../entities/user.entity";
import SmsProvider from "../classes/sms_provider";

export const dashboardPage = async (req:Request,res:Response) => {
    const countAllPowersInStore = await DeviceEntity.getCountAllPowersInStore()
    const countAllCoolersInStore = await DeviceEntity.getCountAllCoolersInStore()
    const countAllPowersOutStore = await DeviceEntity.getCountAllPowersOutStore()
    const countAllCoolersOutStore = await DeviceEntity.getCountAllCoolersOutStore()

    const lastCustomers = await UserEntity.getLastCustomers()

    res.locals.scripts.push('/js/lib/persian-date.js','/js/lib//persian-datepicker.js','/js/dashboard.js')
    res.locals.styles.push('/css/lib/persian-datepicker.css')

    const smsBalance = Math.floor(await SmsProvider.checkPanelCredit()/10).toLocaleString('fa');


    return res.render('dashboard/main.ejs',{
        title:'داشبرد',
        page:'dashboard',
        countAllPowersInStore,
        countAllCoolersInStore,
        countAllPowersOutStore,
        countAllCoolersOutStore,
        lastCustomers,
        smsBalance
    })
}

export const exitAdmin = async (req:Request,res:Response) => {
    req.session.isUserLoggedIn = false;
    req.session.userPhone = undefined
    req.session.loginCode = undefined;
    req.session.loginId = undefined;
    req.session.brokerDetails = undefined;

    return  res.redirect('/dashboard/auth')
}