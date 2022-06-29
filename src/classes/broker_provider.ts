/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * this class use for broker apis
 * @type {BrokerProvider}
 */

import axios from 'axios';
import { brokerUrl } from '../utility/constants';

export default class BrokerProvider {
	static _config = {
		auth: {
			username: '20bf501bc0fa6',
			password: 'MzA1NTY2NTE4NzM5MTk5NzY5MDAyNTEwNzM2NDA1OTU0NTG',
		},
	};

	/**
	 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
	 * @description
	 * add a user to mnesia authentication
	 * @param username
	 * @param password
	 * @return {Promise<AxiosResponse<any>>}
	 */
	static async addUserToMnesia(username: string, password: string) {
		return await axios.post(
			`${brokerUrl}/api/v4/auth_username`,
			{
				username: encodeURIComponent(username),
				password: encodeURIComponent(password),
			},
			this._config,
		);
	}

	static async userExist(username: string) {
		const response = await axios.get(
			`${brokerUrl}/api/v4/auth_username/${username}`,
			this._config,
		);

		if (response.data) {
			return !!response.data.data.username;
		}

		return false;
	}
}
