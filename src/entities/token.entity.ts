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

	static async createToken(userId: Types.ObjectId, agent: string) {
		const { accessToken, refreshToken } = this.generateToken(
			userId.toString(),
		);

		await Token.insertMany({
			token: accessToken,
			refreshToken: refreshToken,
			agent: agent,
			user: userId,
		});

		return {
			accessToken,
			refreshToken,
		} as generateTokenOutput;
	}

	static async removeOldToken(userId: Types.ObjectId, agent: string) {
		await Token.deleteOne({
			agent: agent,
			user: userId,
		});
	}

	static async removeAllUserTokens(userId:Types.ObjectId) {
		await Token.deleteMany({
			user: userId,
		});
	}
}
