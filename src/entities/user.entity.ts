import { sign } from 'jsonwebtoken';
import { Types } from 'mongoose';
import BrokerProvider from '../classes/broker_provider';
import Users, { IUser } from '../models/users.model';
import { jsonWebTokenSecretKey } from '../utility/constants';
import { SHA1 } from 'crypto-js';
import { getUserInformationOutput } from '../types/user.type';

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

	public static async getBrokerUserNamePassword(id: Types.ObjectId) {
		const user: IUser | null = await Users.findOne({ _id: id });

		const usernameBroker = SHA1(
			user!.registerDate.toString() + user!._id!.toString(),
		).toString();
		const passwordBroker = SHA1(
			user!.registerDate.toString() + user?.phoneNumber.toString(),
		).toString();

		const checkUserExists = await BrokerProvider.userExist(usernameBroker);

		if (!checkUserExists) {
			BrokerProvider.addUserToMnesia(usernameBroker, passwordBroker);
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

	public static async getUserInformation(id: Types.ObjectId) {
		const user: IUser | null = await Users.findById(id);

		return {
			phoneNumber: user!.phoneNumber,
			fullName: user!.fullName,
			address: user!.address,
			birthday: user!.birthday,
		} as getUserInformationOutput;
	}
}
