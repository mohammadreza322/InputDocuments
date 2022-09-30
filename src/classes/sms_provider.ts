/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * class that manage send sms to users
 * @type {SmsProvider}
 */

const request = require('request');

export default class SmsProvider {
    private static apiKey = '77ea86d1fee701d5f493d9d774562cd5648412db622a05c44295a9ed97965d75';

    private static smsNumber = '10008566';

    private static url = 'https://api.ghasedak.me/v2/';

    static sendOTPCode(code: string, mobileNumber: string) {
        this.sendSms(mobileNumber, `به چیسکو خوش آمدید\r\nکد ورود:${code}`,)
    }

     static async checkPanelCredit():Promise<number> {
        const options = {
            method: 'POST',
            url: 'https://api.ghasedak.me/v2/account/info',
            headers:
                {
                    'cache-control': 'no-cache',
                    apikey: this.apiKey,
                    'content-type': 'application/x-www-form-urlencoded'
                },
            form: {}
        };

        return new Promise(function (resolve, reject) {
            request(options, function (error, response, body) {
                if (error) {
                    console.error('send sms error');
                    console.error(error);
                    return resolve(0)

                    // return;
                }

                try{
                    const jsonBody = JSON.parse(body);

                    console.log(jsonBody)
                    return resolve(jsonBody.items.balance)

                } catch (e) {
                    return resolve(0)
                }
                // console.log(body)
            });

        })

    }



    private static sendSms(receptor: string, message: string) {
        const method: string = 'POST'

        const options = {
            method,
            url: `${this.url}sms/send/simple`,
            headers: {
                'cache-control': 'no-cache',
                'apikey': this.apiKey,
                'content-type': 'application/x-www-form-urlencoded'
            },
            form: {
                message: message,
                receptor: receptor,
                linenumber: this.smsNumber
            }
        }

        request(options, function (error, response, body) {
            if (error) {
                console.error('send sms error');
                console.error(error);
                return;
            }

            console.log(body)
        })
    }


}
