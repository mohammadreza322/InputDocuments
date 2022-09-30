/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * this class use for broker apis
 * @type {BrokerProvider}
 */


const request = require('request')
import {brokerUrlAPI} from '../utility/constants';

export default class BrokerProvider {
    private static username = '20bf501bc0fa6'
    private static pass = 'MzA1NTY2NTE4NzM5MTk5NzY5MDAyNTEwNzM2NDA1OTU0NTG'

    /**
     * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
     * @description
     * add a user to mnesia authentication
     * @param username
     * @param password
     * @return {Promise<AxiosResponse<any>>}
     */
    static async addUserToMnesia(username: string, password: string) {
        var options = {
            'method': 'POST',
            'url': 'http://185.204.197.144:8081/api/v4/auth_username',
            'headers': {
                'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw==',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                "username": username,
                "password": password
            })

        }
        return await request(options, function (error, response) {
            if (error) {
                console.error('inside add mnesia user')
                console.error(error)
                return false;
            }
            return true;
        });

    }

    static async userExist(username: string) {
        const  options = {
            'method': 'GET',
            'url': `http://185.204.197.144:8081/api/v4/auth_username/${username}`,
            'headers': {
                'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw=='
            }
        };
        return await request(options, function (error, response) {
            if (error) {
                console.error('inside check mnesia user')
                console.error(error)
                return false;
            }
            return true
        });
    }

    static async kickDevice(serialNumber: string) {
        const  options = {
            'method': 'GET',
            'url': `http://185.204.197.144:8081/api/v4/clients/${serialNumber}`,
            'headers': {
                'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw=='
            }
        };
        return  await request(options, function (error, response) {
            if (error) {
                console.error('inside check kick mnesia')
                console.error(error)
                return false;
            }
            return true
        });
    }
}
