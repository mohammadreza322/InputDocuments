/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * this class use for broker apis
 * @type {BrokerProvider}
 */

import axios from 'axios';
import { brokerUrlAPI } from '../utility/constants';

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
		const response = await axios
			.post(
				`${brokerUrlAPI}/api/v4/auth_username`,
				{
					username: encodeURIComponent(username),
					password: encodeURIComponent(password),
				},
				this._config,
			)
			.catch((e) => {
				console.error('error in add user mnesia response');
				console.error(e);
			});
		return response;
	}

	static async userExist(username: string) {
		const response = await axios
			.get(
				`${brokerUrlAPI}/api/v4/auth_username/${username}`,
				this._config,
			)
			.catch((e) => {
				console.error('error in exists user mnesia response');
				console.error(e);
			});

		if (response) {
			return Object.keys(response.data.data).length !== 0;
		}

		return false;
	}
}
