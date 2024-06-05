import {Request, Response} from "express";
import TokenEntity from "../entities/token.entity";
import DeviceEntity from "../entities/device.entity";
import {Types,isValidObjectId} from "mongoose";
import Users from "../models/users.model";
import UserEntity from "../entities/user.entity";
import LogsEntity from "../entities/logs.entity";


export const deleteCustomer = async (req:Request,res:Response) => {
    try {
        const {id} = req.body


        if (!id) {
            return res.json({status: false, message: 'خطا در ورودی'})
        }

        if (id.toString().trim() == '') {
            return res.json({status: false, message: 'خطا در ورودی'})
        }

        const _id = new Types.ObjectId(id)

        const user = await UserEntity.getUserInformation(new Types.ObjectId(_id))

        if(!user) {
            return res.json({status: false, message: 'خطا در ورودی'})
        }

        await LogsEntity.removeCustomer(user.fullName,req.user.id)

        await TokenEntity.removeAllUserTokens(_id)
        await DeviceEntity.removeAllDeviceOfUser(_id)
        await UserEntity.removeUser(_id)

        return res.json({status: true, message: 'حذف کاربر با موفقیت انجام شد'})
    }catch (err) {
        console.error('inside remove user');
        console.error(err);

        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
}

export const editUser = async (req:Request,res:Response) => {
    try {
        const {id, fullName, phoneNumber, address, birthday} = req.body

        if (!id || !fullName || !phoneNumber) {
            return res.json({status: false, message: 'خطا در ورودی'})
        }

        if (id.toString().trim() == '') {
            return res.json({status: false, message: 'خطا در ورودی'})
        }

        if (!isValidObjectId(id)) {
            return res.json({status: false, message: 'خطا در ورودی'})
        }

        if (fullName.toString().trim() == '') {
            return res.json({status: false, message: 'نام و نام خانوادگی را وارد کنید'})
        }

        if (phoneNumber.toString().trim() == '') {
            return res.json({status: false, message: 'شماره تماس را وارد کنید'})
        }

        const data = {
            id, fullName, phoneNumber
        }

        if (address) {
            data['address'] = address;
        }

        if (birthday) {
            data['birthday'] = birthday;
        }

        const user = await  UserEntity.getUserInformation(new Types.ObjectId(id));

        if(!user) {
            return res.json({status: false, message: 'خطا در ورودی'})
        }

        if(await UserEntity.checkPhoneNumberWithId(new Types.ObjectId(id),phoneNumber)){
            return res.json({status: false, message: 'شماره تماس وارد شده مربوط به کاربر دیگری میباشد'})
        }
        if(user.phoneNumber != phoneNumber){
            await LogsEntity.changeUserPhoneNumber(user.phoneNumber,phoneNumber,user.fullName,req.user.id)
        }


        await UserEntity.setUserDetailsWithPhoneNUmber(new Types.ObjectId(id), fullName, phoneNumber, birthday, address)

        return res.json({status: true, message: 'اطلاعات کاربر با موفقیت تغییر کرد'})
    }catch (err) {
        console.error('inside remove user');
        console.error(err);

        return res.status(500).json({ message: 'خطایی پیش آمده' });
    }
}