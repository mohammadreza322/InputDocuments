/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * this class use for broker apis
 * @type {BrokerProvider}
 */


const request = require('request')
import {brokerUrlAPI} from '../utility/constants';

export default class BrokerProvider {
    private static authorization = 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw=='

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
            'url': `${brokerUrlAPI}/auth_username`,
            'headers': {
                'Authorization': this.authorization,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                "username": username,
                "password": password
            })

        }
        return new Promise((resolve, reject) => {
            request(options, function (error, response) {
                if (error) {
                    console.error('inside add mnesia user')
                    console.error(error)
                    return resolve(false);
                }
                return resolve(true);
            })
        });

    }

    static async userExist(username: string) {
        const options = {
            'method': 'GET',
            'url': `${brokerUrlAPI}/auth_username/${username}`,
            'headers': {
                'Authorization': this.authorization
            }
        };
        return new Promise(function (resolve, reject) {
            request(options, function (error, response) {
                if (error) {
                    console.error('inside check mnesia user')
                    console.error(error)
                    return resolve(false);
                }
                console.log(response)
                const data = JSON.parse(response.body)
                if(data.data){
                    if(data.data.username){
                        return resolve(true)
                    }
                    return resolve(false)
                }
                return resolve(false)
            });
        })
    }

    static async kickDevice(serialNumber: string) {
        const options = {
            'method': 'GET',
            'url': `${this.authorization}/clients/${serialNumber}`,
            'headers': {
                'Authorization': this.authorization
            }
        };
        return new Promise((resolve, reject) => {
            request(options, function (error, response) {
                if (error) {
                    console.error('inside check kick mnesia')
                    console.error(error)
                    return resolve(false);
                }
                return resolve(true)
            });
        })
    }
}
