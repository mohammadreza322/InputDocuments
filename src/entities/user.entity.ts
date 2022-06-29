import { sign } from 'jsonwebtoken';
import { Types } from 'mongoose';
import BrokerProvider from '../classes/broker_provider';
import Users, { IUser } from '../models/users.model';
import { jsonWebTokenSecretKey } from '../utility/constants';

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

		const usernameBroker = CryptoJS.SHA1(
			user!.registerDate.toString() + user!._id!.toString(),
		).toString();
		const passwordBroker = CryptoJS.SHA1(
			user!.registerDate.toString() + user?.phoneNumber.toString(),
		).toString();

		if (await !BrokerProvider.userExist(usernameBroker)) {
			BrokerProvider.addUserToMnesia(usernameBroker, passwordBroker);
		}

		return sign(
			{
				usernameBroker,
				passwordBroker,
			},
			jsonWebTokenSecretKey,
			{
				expiresIn: '5m  ',
			},
		);
	}
}
