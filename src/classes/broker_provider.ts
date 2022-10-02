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
    private static pass = 'jEwsRgWmOHAaPk1BpC0IkF4IvElXgMB6cswEhpv02zN'

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
            'url': 'http://185.164.73.252:8081/api/v4/auth_username',
            'headers': {
                'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpqRXdzUmdXbU9IQWFQazFCcEMwSWtGNEl2RWxYZ01CNmNzd0VocHYwMnpO',
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
            'url': `http://185.164.73.252:8081/api/v4/auth_username/${username}`,
            'headers': {
                'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpqRXdzUmdXbU9IQWFQazFCcEMwSWtGNEl2RWxYZ01CNmNzd0VocHYwMnpO'
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
            'url': `http://185.164.73.252:8081/api/v4/clients/${serialNumber}`,
            'headers': {
                'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpqRXdzUmdXbU9IQWFQazFCcEMwSWtGNEl2RWxYZ01CNmNzd0VocHYwMnpO'
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
