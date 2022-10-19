import Logs from "../models/logs";
import {Types} from "mongoose";
import DeviceEntity from "./device.entity";

export default class LogsEntity {
    static async changeUserPhoneNumber(oldPhone:string, newPhone:string, userFullName:string, adminId:Types.ObjectId) {
        return await this.addLog(`تغییر شماره تلفن کاربر “${userFullName}” از ${oldPhone} به ${newPhone}.`,adminId)
    }

    static async removeCustomer(userFullName:string,adminId:Types.ObjectId){
        return await this.addLog(`حذف کردن کاربر “${userFullName}” از لیست کاربران.`,adminId)
    }

    static async addDevicePower(serialNumber:string,adminId:Types.ObjectId,deviceId:Types.ObjectId) {
        // await this.addLog('ورود اولیه به سیستم.',deviceId);
        return await this.addLog(`اضافه کردن دستگاه سه راهه با شماره سریال “${serialNumber}”.`,adminId)
    }

    static async addDeviceCooler(serialNumber:string,adminId:Types.ObjectId,deviceId:Types.ObjectId) {
        // await this.addLog('ورود اولیه به سیستم.',deviceId);
        return await this.addLog(`اضافه کردن دستگاه کولر با شماره سریال “${serialNumber}”.`,adminId)
    }

    static async kickDeviceFromBroker(serialNumber:string,adminId:Types.ObjectId,adminName:string) {
        const id = await DeviceEntity.getIdOfDevice(serialNumber)
        await this.addLog(`حذف از بروکر توسط مدیر “${adminName}”.`,id)

        return await this.addLog(`حذف دستگاه “${serialNumber}” از بروکر.`,adminId)
    }

    static async loginAdmin(adminId:Types.ObjectId) {
        return await this.addLog(`ورود به سیستم.`,adminId)
    }

    static async deviceReconnectToServer(serialNumber:string){
        const id = await DeviceEntity.getIdOfDevice(serialNumber)

        if(id){
            return await this.addLog('اتصال مجدد به سیستم.',id)
        }
    }

    static async deviceDisconnectToServer(serialNumber:string){
        const id = await DeviceEntity.getIdOfDevice(serialNumber)

        if(id){
            return await this.addLog('قطع ارتباط با سیستم.',id)
        }
    }

    static async getLogs(logId:Types.ObjectId) {
        return Logs.find({logId}).sort({'date': -1}).limit(5);
    }

    private static async addLog(message:string, logId:Types.ObjectId){
        return await Logs.insertMany([{
            message:message,
            logId
        }])
    }
}