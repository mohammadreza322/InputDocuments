import {
	accessTokenExpireTime,
	refreshTokenExpireTime,
	jsonWebTokenSecretKey,
} from '../utility/constants';
import Token from '../models/tokens.model';
import { sign, verify } from 'jsonwebtoken';
import { Types } from 'mongoose';
export interface generateTokenOutput {
	accessToken: string;
	refreshToken: string;
}
export default class TokenEntity {
	private static generateToken(userId: string) {
		const accessToken = sign({ id: userId }, jsonWebTokenSecretKey, {
			expiresIn: accessTokenExpireTime,
		});

		const refreshToken = sign({ id: userId }, jsonWebTokenSecretKey, {
			expiresIn: refreshTokenExpireTime,
		});

		return {
			accessToken,
			refreshToken,
		} as generateTokenOutput;
	}

	static async createToken(userId: string, agent: string) {
		const { accessToken, refreshToken } = this.generateToken(userId);

		const user = Types.ObjectId.createFromHexString(userId);
		await Token.insertMany({
			token: accessToken,
			refreshToken: refreshToken,
			agent: agent,
			user,
		});

		return {
			accessToken,
			refreshToken,
		} as generateTokenOutput;
	}
}
