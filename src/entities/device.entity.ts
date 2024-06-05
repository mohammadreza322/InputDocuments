import {Types, ObjectId} from 'mongoose';
import AhpMqtt from '../classes/mqtt';
import {
    Cooler,
    ICooler,
    IPowerStrip,
    PowerStrip,
} from '../models/device.model';
// import Device from '../models/device.model';
import {
    saveScheduleInput,
    listOfDevices,
    validateSerialNumberOutput,
    addSchedule,
    IScheduleObject,
    editSchedule,
} from '../types/device.type';
import Users, {IUser} from "../models/users.model";
import PersianDate from "@alireza-ab/persian-date";
import LogsEntity from "./logs.entity";

export default class DeviceEntity {
    static async getAllDevices(userId: Types.ObjectId) {
        const powerStrips: Array<IPowerStrip> | null = await PowerStrip.find(
            {
                owner: userId,
            },
            {_id: 0, 'connectors._id': 0, __v: 0, registerAt: 0, owner: 0,createAt:0,password:0,insertedUser:0},
        );

        const coolers: Array<ICooler> | null = await Cooler.find(
            {
                owner: userId,
            },
            {_id: 0, __v: 0, owner: 0, registerAt: 0,createAt:0,password:0,insertedUser:0},
        );

        const devices: listOfDevices = {
            powers: [],
            coolers: [],
            categories: [],
        };

        for (const power of powerStrips) {
            devices.powers.push({
                connectors:power.connectors,
                connectionStatus:power.deviceLastConnection == 'آنلاین',
                totalVoltage:power.totalVoltage,
                schedule:power.schedule,
                serialNumber:power.serialNumber,
                name:power.name,
                category:power.category,
                owner:power.owner,
                deviceLastConnection:power.deviceLastConnection
            });


            if (power.category) {
                if (!devices.categories.includes(power.category)) {
                    devices.categories.push(power.category);
                }
            }
        }

        for (const cooler of coolers) {
            devices.coolers.push({
                category:cooler.category,
                connectionStatus:cooler.deviceLastConnection == 'آنلاین',
                deviceLastConnection:cooler.deviceLastConnection,
                fan:cooler.fan,
                horizontalSwing:cooler.horizontalSwing,
                mode:cooler.mode,
                model:cooler.model,
                name:cooler.name,
                owner:cooler.owner,
                power:cooler.power,
                schedule:cooler.schedule,
                serialNumber:cooler.serialNumber,
                temp:cooler.temp,
                timer:cooler.timer,
                verticalSwing:cooler.verticalSwing
            });
            if (cooler.category) {
                if (!devices.categories.includes(cooler.category)) {
                    devices.categories.push(cooler.category);
                }
            }
        }

        return devices;
    }

    static async validateSerialNumber(
        serialNumber: string,
        userId: Types.ObjectId,
        validateType: string,
    ): Promise<validateSerialNumberOutput> {
        const output: validateSerialNumberOutput = {
            message: '',
            valid: false,
            type: '',
        };

        output.message = 'شماره سریال وارد شده معتبر نیست!';

        const powerDetails = await PowerStrip.findOne({serialNumber});

        const coolerDetails = await Cooler.findOne({serialNumber});

        var device = undefined;

        if (!powerDetails && !coolerDetails) {
            return output;
        }

        if (powerDetails) {
            device = powerDetails;
            output.type = 'power';
        } else if (coolerDetails) {
            device = coolerDetails;
            output.type = 'cooler';
        } else {
            return output;
        }

        if (device?.owner) {
            if (!userId.equals(device.owner)) {
                output.message = 'این دستگاه قبلا ثبت شده است';
                return output;
            }
        } else {
            if (validateType === 'delete' || validateType === 'addSchedule') {
                output.message = 'شما مالک این دستگاه نیستید';
                return output;
            }
        }

        output.valid = true;
        return output;
    }

    static async validateSerialNumberForAdmin(
        serialNumber: string,

    ): Promise<validateSerialNumberOutput> {
        const output: validateSerialNumberOutput = {
            message: '',
            valid: false,
            type: '',
        };

        output.message = 'شماره سریال وارد شده معتبر نیست!';

        const powerDetails = await PowerStrip.findOne({serialNumber});

        const coolerDetails = await Cooler.findOne({serialNumber});

        var device = undefined;

        if (!powerDetails && !coolerDetails) {
            return output;
        }

        if (powerDetails) {
            device = powerDetails;
            output.type = 'power';
        } else if (coolerDetails) {
            device = coolerDetails;
            output.type = 'cooler';
        } else {
            return output;
        }

        output.valid = true;
        return output;
    }

    static async saveCooler(
        serialNumber: string,
        model: string,
        name: string,
        category: string,
        userId: Types.ObjectId,
    ) {
        await Cooler.updateOne(
            {serialNumber},
            {
                $set: {
                    model,
                    name,
                    category,
                    owner: userId,
                    registerAt: Date.now(),
                },
            },
        );

        AhpMqtt.getInstance().publish(
            `/chisco/change_model/${serialNumber}`,
            JSON.stringify({model}),
        );
    }

    static async savePower(
        serialNumber: string,
        category: string,
        name: string,
        userId: Types.ObjectId,
        power1?: string,
        power2?: string,
        power3?: string,
        power4?: string,
        usb1?: string,
        usb2?: string,
    ) {
        await PowerStrip.updateOne(
            {serialNumber},
            {
                $set: {
                    name,
                    category,
                    owner: userId,
                    connectors: [
                        {
                            name: power1 ?? '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 1,
                        },
                        {
                            name: power2 ?? '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 2,
                        },
                        {
                            name: power3 ?? '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 3,
                        },
                        {
                            name: power4 ?? '',
                            connectorType: 'power',
                            status: true,
                            connectorId: 4,
                        },
                        {
                            name: usb1 ?? '',
                            connectorType: 'usb',
                            status: true,
                            connectorId: 5,
                        },
                        {
                            name: usb2 ?? '',
                            connectorType: 'usb',
                            status: true,
                            connectorId: 6,
                        },
                    ],
                    registerAt: Date.now(),
                },
            },
        );
    }

    static async deleteOwnerDevice(serialNumber: string, type: string) {
        if (type === 'cooler') {
            await Cooler.updateOne(
                {serialNumber: serialNumber},
                {
                    $set: {
                        owner: null,
                        name: null,
                        category: null,
                        schedule: [],
                        registerAt: null,
                        temp: null,
                        mode: 'Auto',
                        horizontalSwing: 'Auto',
                        verticalSwing: 'Auto',
                        fan: 'Auto',
                        timer: 'Off',
                    },
                },
            );
        } else if (type === 'power') {
            await PowerStrip.updateOne(
                {serialNumber},
                {
                    $set: {
                        owner: null,
                        name: null,
                        category: null,
                        schedule: [],
                        registerAt: null,
                        totalVoltage: 0,
                        connectors: [],
                    },
                },
            );
        }

        // AhpMqtt.getInstance().publish(
        //     `/chisco/deleteOwner/${serialNumber}`,
        //     JSON.stringify({delete: true}),
        // );
        return true;
    }

    static async addSchedule({
                                 serialNumber,
                                 startTime,
                                 endTime,
                                 repeat,
                                 portNumber,
                                 type,
                             }: addSchedule) {
        const scheduleObject: IScheduleObject = {
            endTime,
            startTime,
            repeat,
            enable: true,
        };
        if (type === 'power') {
            scheduleObject.port = portNumber;

            const power: IPowerStrip | null = await PowerStrip.findOne({
                serialNumber,
            });

            if (power) {
                power.schedule.push({
                    start: startTime?.toString(),
                    end: endTime?.toString(),
                    repeat,
                    port: portNumber,
                    enable: true,
                });
                await power.save();

                scheduleObject.id =
                    power.schedule[power.schedule.length - 1]._id;
            }
        } else if (type === 'cooler') {
            const cooler: ICooler | null = await Cooler.findOne({
                serialNumber,
            });
            if (cooler) {
                cooler.schedule.push({
                    start: startTime?.toString(),
                    end: endTime?.toString(),
                    repeat,
                    enable: true,
                });
                await cooler.save();

                scheduleObject.id =
                    cooler.schedule[cooler.schedule.length - 1]._id;
            }
        }

        AhpMqtt.getInstance().publish(
            `/chisco/set_schedule/${serialNumber}`,
            JSON.stringify(scheduleObject),
        );
    }

    static async editSchedule({
                                  serialNumber,
                                  startTime,
                                  endTime,
                                  repeat,
                                  portNumber,
                                  type,
                                  enable,
                                  _id,
                              }: editSchedule) {
        const scheduleObject: IScheduleObject = {
            id: new Types.ObjectId(_id),
            enable: enable!,
            startTime,
            endTime,
            repeat,
        };

        if (type === 'power') {
            scheduleObject.port = portNumber;
            await PowerStrip.updateOne(
                {serialNumber, 'schedule._id': _id},
                {
                    $set: {
                        'schedule.$.start': startTime,
                        'schedule.$.end': endTime,
                        'schedule.$.repeat': repeat,
                        'schedule.$.port': portNumber,
                        'schedule.$.enable': enable,
                    },
                },
            );
        } else if (type === 'cooler') {
            await Cooler.updateOne(
                {serialNumber, 'schedule._id': _id},
                {
                    $set: {
                        'schedule.$.start': startTime,
                        'schedule.$.end': endTime,
                        'schedule.$.repeat': repeat,
                        'schedule.$.enable': enable,
                    },
                },
            );
        }

        AhpMqtt.getInstance().publish(
            `/chisco/set_schedule/${serialNumber}`,
            JSON.stringify(scheduleObject),
        );
    }

    static async deleteSchedule(
        serialNumber: string,
        id: Types.ObjectId,
        type: string,
    ): Promise<void> {
        if (type == 'power') {
            await PowerStrip.updateOne(
                {serialNumber},
                {
                    $pull: {
                        schedule: {
                            _id: id,
                        },
                    },
                },
            );
        } else if (type == 'cooler') {
            await Cooler.updateOne(
                {serialNumber: serialNumber},
                {
                    $pull: {
                        schedule: {
                            _id: id,
                        },
                    },
                },
            );
        }
        AhpMqtt.getInstance().publish(
            `/chisco/delete_schedule/${serialNumber}`,
            JSON.stringify({id}),
        );
    }


    static async getCountAllPowersInStore() {
        return await PowerStrip.countDocuments({owner: {$eq: null}}) | 0
    }

    static async getCountAllCoolersInStore() {
        return await Cooler.countDocuments({owner: {$eq: null}}) | 0
    }

    static async getCountAllPowersOutStore() {
        return await PowerStrip.countDocuments({owner: {$ne: null}}) | 0
    }

    static async getCountAllCoolersOutStore() {
        return await Cooler.countDocuments({owner: {$ne: null}}) | 0
    }

    static async getAllDevicesCount(userId: Types.ObjectId) {
        const powerStrips: number = await PowerStrip.countDocuments(
            {
                owner: userId,
            },
        );

        const coolers: number = await Cooler.countDocuments(
            {
                owner: userId,
            },
        );


        return powerStrips + coolers;
    }

    public static async removeAllDeviceOfUser(userId: Types.ObjectId) {
        await PowerStrip.updateMany({owner: userId}, {
            $set: {
                owner: null,
                category: null,
                name: null,
                totalVoltage: 0,
                schedule: [],
                registerAt: null,
                deviceLastConnection: null
            }
        })

        await Cooler.updateMany({owner: userId}, {
            $set: {
                owner: null,
                category: null,
                name: null,
                brand: null,
                model: null,
                temp: 20,
                mode: 'Auto',
                horizontalSwing: 'Auto',
                verticalSwing: 'Auto',
                fan: 'Auto',
                timer: 'Off',
                schedule: [],
                power: true
            }
        })
    }

    public static async getAllPowers(page: number, limit: number) {
        const powers = await PowerStrip.find({owner: {$ne: null}}, {
            serialNumber: 1,
            owner: 1,
            registerAt: 1,
            deviceLastConnection: 1,
            createAt: 1
        })
            .populate<{ owner: IUser }>({path: 'owner', model: Users})
           .sort({registerAt: -1})
            .skip(limit * (page - 1))
            .limit(limit)
        const output = []
        for (const power of powers) {
            const createAtJalali = new PersianDate(`${power.createAt.getFullYear()}-${power.createAt.getMonth() + 1}-${power.createAt.getDate()}`).calendar('jalali').toString()
            const activateJalaliDate = power.registerAt ? new PersianDate(`${power.registerAt.getFullYear()}-${power.registerAt.getMonth() + 1}-${power.registerAt.getDate()}`).calendar('jalali').toString() : 'ندارد';
            let lastStatus =  'ندارد'
            if(power.deviceLastConnection){

                if(power.deviceLastConnection == 'آنلاین'){
                    lastStatus = 'آنلاین';
                }else{
                
            
                const date= new Date(parseInt(power.deviceLastConnection.toString())*1)
                lastStatus = new PersianDate(`${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`).calendar('jalali').toString()
                }
           
            }
            output.push({
                serialNumber: power.serialNumber,
                fullName: power.owner.fullName,
                phoneNumber: power.owner.phoneNumber,
                createAtJalali,
                activateJalaliDate,
                lastStatus

            })
        }

        return output;
    }

    public static async getAllPowersInStore(page: number, limit: number) {
        const powers = await PowerStrip.find({owner: {$eq: null}}, {
            serialNumber: 1,
            password: 1,
            createAt: 1,
            insertedUser:1,
            _id:1
        })
            .populate<{ insertedUser: IUser }>({path: 'insertedUser', model: Users})

            .skip(limit * (page - 1))
            .limit(limit)
            .sort({createAt: -1})
        const output = []
        for (const power of powers) {
            const createAtJalali = new PersianDate(`${power.createAt.getFullYear()}-${power.createAt.getMonth() + 1}-${power.createAt.getDate()}`).calendar('jalali').toString()
            const fullName = power.insertedUser ? power.insertedUser.fullName : 'ندارد'
            const logsDetails = await LogsEntity.getLogs(power._id)
            const logs = logsDetails.map(log => {
                const date = new PersianDate(`${log.date.getFullYear()}-${log.date.getMonth() + 1}-${log.date.getDate()} ${log.date.getHours()}:${log.date.getMinutes()}`).calendar('jalali')
                return {
                    message:log.message,
                    date: date.toString('datetime')
                }
            })
            output.push({
                serialNumber: power.serialNumber,
                fullName: fullName,
                password:power.password,
                createAtJalali,
                id:power._id,
                logs:JSON.stringify(logs)
            })
        }

        return output;
    }

    public static async getAllCoolers(page: number, limit: number) {
        const coolers = await Cooler.find({owner: {$ne: null}}, {
            serialNumber: 1,
            owner: 1,
            registerAt: 1,
            deviceLastConnection: 1,
            createAt: 1,

        })
            .populate<{ owner: IUser }>({path: 'owner', model: Users})
            .sort({registerAt: -1})
            .skip(limit * (page - 1))
            .limit(limit)

        const output = []

        for (const cooler of coolers) {
            const createAtJalali = new PersianDate(`${cooler.createAt.getFullYear()}-${cooler.createAt.getMonth() + 1}-${cooler.createAt.getDate()}`).calendar('jalali').toString()
            const activateJalaliDate = cooler.registerAt ? new PersianDate(`${cooler.registerAt.getFullYear()}-${cooler.registerAt.getMonth() + 1}-${cooler.registerAt.getDate()}`).calendar('jalali').toString() : 'ندارد';

            let lastStatus = 'ندارد'
            if(cooler.deviceLastConnection  ){
                if(cooler.deviceLastConnection=='آنلاین'){
                    lastStatus = 'آنلاین'
                }else{
                    const date= new Date(parseInt(cooler.deviceLastConnection.toString())*1)
                    lastStatus = new PersianDate(`${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`).calendar('jalali').toString()
                }
            }
            const logsDetails = await LogsEntity.getLogs(cooler._id)
            const logs = logsDetails.map(log => {
                const date = new PersianDate(`${log.date.getFullYear()}-${log.date.getMonth() + 1}-${log.date.getDate()} ${log.date.getHours()}:${log.date.getMinutes()}`).calendar('jalali')
                return {
                    message:log.message,
                    date: date.toString('datetime')
                }
            })
            output.push({
                serialNumber: cooler.serialNumber,
                fullName: cooler.owner.fullName,
                phoneNumber: cooler.owner.phoneNumber,
                createAtJalali,
                activateJalaliDate,
                lastStatus,
                logs:JSON.stringify(logs)
            })
        }

        return output;
    }

    public static async getAllCoolersInStore(page: number, limit: number) {
        const coolers = await Cooler.find({owner: {$eq: null}}, {
            serialNumber: 1,
            password: 1,
            createAt: 1,
            insertedUser:1,
            _id:1
        })
            .populate<{ insertedUser: IUser }>({path: 'insertedUser', model: Users})
            .sort({createAt: -1})
            .skip(limit * (page-1 ))
            .limit(limit)

        const output = []

        for (const cooler of coolers) {
            const createAtJalali = new PersianDate(`${cooler.createAt.getFullYear()}-${cooler.createAt.getMonth() + 1}-${cooler.createAt.getDate()}`).calendar('jalali').toString()
            const fullName = cooler.insertedUser ? cooler.insertedUser.fullName : 'ندارد'
            output.push({
                serialNumber: cooler.serialNumber,
                fullName: fullName,
                password:cooler.password,
                createAtJalali,
                id:cooler._id
            })
        }

        return output;
    }

    public static async addPower(serialNumber:string,password:string,userId:Types.ObjectId) {
        const power = new PowerStrip()
        power.serialNumber = serialNumber
        power.password= password;
        power.insertedUser = userId;
        power.connectors = [
            {
                status:true,
                connectorType:'power',
                connectorId:1
            },
            {
                status:true,
                connectorType:'power',
                connectorId:2
            },
            {
                status:true,
                connectorType:'power',
                connectorId:3
            },
            {
                status:true,
                connectorType:'power',
                connectorId:4
            },
            {
                status:true,
                connectorType:'usb',
                connectorId:5
            },
            {
                status:true,
                connectorType:'usb',
                connectorId:6
            },
        ]
        await power.save()

        return power._id
    }

    public static async addCooler(serialNumber:string,password:string,userId:Types.ObjectId){
        const cooler = new Cooler()
        cooler.serialNumber = serialNumber;
        cooler.password = password;
        cooler.insertedUser = userId
        await cooler.save()

        return cooler._id
    }

    public static async coolerExists(serialNumber:string) {
        return Cooler.exists({serialNumber});
    }

    public static async powerExists(serialNumber:string) {
        return PowerStrip.exists({serialNumber});
    }

    public static async deviceExists(serialNumber:string) {
        const powerExists = await PowerStrip.exists({serialNumber});
        const coolerExists = await Cooler.exists({serialNumber});
        return powerExists && coolerExists
    }

    public static async removeCooler(serialNumber:string){
        return Cooler.deleteOne({serialNumber})
    }

    public static async removePower(serialNumber:string){
        return PowerStrip.deleteOne({serialNumber})
    }

    public static async getIdOfDevice(serialNumber:string) {
        let device = await PowerStrip.findOne({serialNumber})

        if(device) {
            return device._id
        }

        device = await Cooler.findOne({serialNumber})

        return device._id
    }
}
