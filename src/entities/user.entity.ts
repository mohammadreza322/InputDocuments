import {sign} from 'jsonwebtoken';
import {Types} from 'mongoose';
import BrokerProvider from '../classes/broker_provider';
import Users, {IUser} from '../models/users.model';
import {jsonWebTokenSecretKey} from '../utility/constants';
import {SHA1} from 'crypto-js';
import {getUserFullInformationOutput, getUserInformationOutput, lastCustomersOutput} from '../types/user.type';
import DeviceEntity from "./device.entity";
import PersianDate from "@alireza-ab/persian-date";
import {adminRoleTranslate} from "../classes/convert";
import LogsEntity from "./logs.entity";
import {stringify} from "querystring";

export default class UserEntity {
	public static async setUserDetails(
		id: Types.ObjectId,
		fullName: string,
		birthday?: Date,
		address?: string,
	) {
		try {
			await Users.updateOne(
				{ _id: id },
				{
					$set: {
						fullName,
						birthday,
						address,
					},
				},
			);
			return true;
		} catch (error) {
			console.error('inside user entity set user details');
			console.error(error);
			return false;
		}
	}

	public static async setUserDetailsWithPhoneNUmber(
		id: Types.ObjectId,
		fullName: string,
		phone:string,
		birthday?: Date,
		address?: string,
	) {
		try {
			await Users.updateOne(
				{ _id: id },
				{
					$set: {
						fullName,
						birthday,
						address,
						phoneNumber:phone
					},
				},
			);
			return true;
		} catch (error) {
			console.error('inside user entity set user details');
			console.error(error);
			return false;
		}
	}

	public static async getBrokerUserNamePassword(id: Types.ObjectId) {
		const user: IUser | null = await Users.findOne({ _id: id });

		const usernameBroker = SHA1(
			user!.registerDate.toString() + user!._id!.toString(),
		).toString();
		const passwordBroker = SHA1(
			user!.registerDate.toString() + user?.phoneNumber.toString(),
		).toString();

		const checkUserExists = await BrokerProvider.userExist(usernameBroker);

		// console.log(checkUserExists)

		if (!checkUserExists) {
			// console.log("add user mnesia")
			await BrokerProvider.addUserToMnesia(usernameBroker, passwordBroker);
		}

		return sign(
			{
				usernameBroker,
				passwordBroker,
			},
			jsonWebTokenSecretKey,
			{
				expiresIn: '5m',
			},
		);
	}

	public static async getUserInformation(id: Types.ObjectId):Promise<getUserInformationOutput | null>  {
		const user: IUser | null = await Users.findById(id);

		if(!user) {
			return null;
		}

		let birthday = null
		if(user.birthday){
			birthday = Math.ceil(user.birthday.getTime()/1000)
		}

		return {
			phoneNumber: user!.phoneNumber,
			fullName: user!.fullName,
			address: user!.address,
			birthday: birthday,
		} as getUserInformationOutput;
	}

	public static async getUserInformationWithPhoneNumber(phone: string) {
		const user: IUser | null = await Users.findOne({phoneNumber:phone});

		let birthday = null
		if(user.birthday){
			birthday = Math.ceil(user.birthday.getTime()/1000)
		}

		return {
			phoneNumber: user!.phoneNumber,
			fullName: user!.fullName,
			address: user!.address,
			birthday: birthday,
			role:user!.role,
			id:user.id,
			registerDate:user!.registerDate
		} as getUserFullInformationOutput;
	}

	public static async isUserCanLoginInDashboard(id: Types.ObjectId) {
		const user: IUser | null = await Users.findById(id);

		if(!user) {
			return false;
		}

		if(user.role =='user') {
			return false;
		}

		if(!user.enable) {
			return false;
		}

		return true;
	}

	public static async getLastCustomers() {
		const users:Array<IUser> = await Users.find({role:'user'})
			.sort({registerDate:-1})
			.limit(10)

		const output = []
		for(const user of users) {

			const countDevices = await DeviceEntity.getAllDevicesCount(user._id)

			const userJalaliPersianDate =new PersianDate(user.registerDate).calendar('jalali').toString()

			user.address = user.address ? user.address.trim().length > 0 ? user.address.trim() : 'ندارد' : 'ندارد'

			const userJalaliBirthday = !user.birthday ? 'ندارد' : new PersianDate(`${user.birthday.getFullYear()}-${user.birthday.getMonth()+1}-${user.birthday.getDate()}`).calendar('jalali').toString()

			if(countDevices > 0) {
				output.push({
					...user.toObject(),
					countDevices,
					jalaliRegisterDate: userJalaliPersianDate,
					userJalaliBirthday
				} as lastCustomersOutput)
			}
		}

		return output
	}

	public static async removeUser(id:Types.ObjectId) {
		await Users.deleteOne({_id:id})
	}

	public static async getCountAllAdmins() {
		const adminsCount =await Users.countDocuments({role:'admin'}) || 0
		const wareHouseCount =await Users.countDocuments({role:'warehouse'}) || 0
		const customerServiceCount =await Users.countDocuments({role:'customer_service'}) || 0
		return adminsCount+wareHouseCount+customerServiceCount;
	}

	public static async getCountAllClients() {
		return await Users.countDocuments({role: 'user',fullName:{$ne:null}}) || 0;
	}

	public static async addAdmin(fullName:string,phoneNumber:string,access:string,enable:string) {
		return await Users.insertMany([{fullName,phoneNumber,role:access,enable:enable == 'enable'}])
	}

	public static async checkPhoneNumberWithId(id:Types.ObjectId,phoneNumber:string) {
		return await Users.countDocuments({phoneNumber,_id:{$ne:id}}) > 0
	}

	public static async checkPhoneNumberExists(phoneNumber:string) {
		return await Users.countDocuments({phoneNumber}) > 0
	}

	public static async getAllAdmins(page:number,limit:number){
		const admins = await Users
			.find(
				{$or:[{role:'admin'},{role:'warehouse'},{role:'customer_service'}]},
				{fullName:1,phoneNumber:1,_id:1,registerDate:1,role:1,enable:1}
			)
			.sort({registerDate:-1})
			.skip(limit*(page-1))
			.limit(limit)

		const output = []

		for(const admin of admins) {
			// console.log(admin.registerDate)
			const userJalaliPersianDate =new PersianDate(admin.registerDate).calendar('jalali').toString()
			const logsDetails = await LogsEntity.getLogs(admin._id)
			const logs = logsDetails.map(log => {
				const date = new PersianDate(`${log.date.getFullYear()}-${log.date.getMonth() + 1}-${log.date.getDate()} ${log.date.getHours()}:${log.date.getMinutes()}`).calendar('jalali')
				return {
					message:log.message,
					date: date.toString('datetime')
				}
			})

			output.push({
				fullName: admin.fullName,
				phoneNumber:admin.phoneNumber,
				registerDate:userJalaliPersianDate,
				access:admin.role,
				accessTranslate:adminRoleTranslate(admin.role),
				enable:admin.enable,
				enableTranslate: admin.enable ? 'فعال' : 'غیرفعال',
				id:admin._id,
				logs:JSON.stringify(logs)
			})
		}

		return output
	}

	public static async getAllClients(page:number,limit:number){
		const clients = await Users
			.find(
				{role:'user',fullName:{$ne:null}},
				{fullName:1,phoneNumber:1,_id:1,registerDate:1,address:1,birthday:1}
			)
			.sort({registerDate:-1})
			.skip(limit*(page-1))
			.limit(limit)

		const output = []

		for(const user of clients) {

			const countDevices = await DeviceEntity.getAllDevicesCount(user._id)

			const userJalaliPersianDate =new PersianDate(user.registerDate).calendar('jalali').toString()

			user.address = user.address ? user.address.trim().length > 0 ? user.address.trim() : 'ندارد' : 'ندارد'

			const userJalaliBirthday = !user.birthday ? 'ندارد' : new PersianDate(`${user.birthday.getFullYear()}-${user.birthday.getMonth()+1}-${user.birthday.getDate()}`).calendar('jalali').toString()


			output.push({
				...user.toObject(),
				countDevices,
				jalaliRegisterDate: userJalaliPersianDate,
				userJalaliBirthday
			} as lastCustomersOutput)

		}

		return output
	}

	public static async editAdmin(id:Types.ObjectId,fullName:string,phoneNumber:string,access:string,enable:string){
		await Users.updateOne({_id:id},{
			$set:{
				fullName,
				phoneNumber,
				role:access,
				enable:enable=='enable'
			}
		})
	}

	public static async editCurrentAdmin(id:Types.ObjectId,fullName:string,phoneNumber:string){
		await Users.updateOne({_id:id},{
			$set:{
				fullName,
				phoneNumber,
			}
		})
	}

	public static async deleteAdmin(id:Types.ObjectId) {
		await Users.deleteOne({_id:id});
		//todo remove logs
	}
}
