/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * class that manage send sms to users
 * @type {SmsProvider}
 */

const request = require('request');

export default class SmsProvider {
    private static apiKey = 'f992710e2dd1b2a825fe2bc1dbf554083632722173329ac9c742f8530620170f';

    private static smsNumber = '30005006007625';

    private static url = 'https://api.ghasedak.me/v2/';

    static sendOTPCode(code: string, mobileNumber: string) {
        const options = {
            method: 'POST',
            url: 'https://api.ghasedak.me/v2/verification/send/simple',
            headers:
                {
                    'cache-control': 'no-cache',
                    apikey: this.apiKey,
                    'content-type': 'application/x-www-form-urlencoded'
                },
            form:
                {
                    receptor: mobileNumber,
                    template: 'otp',
                    type: '1',
                    param1: code
                }
        };

        request(options, function (error, response, body) {
            if (error) throw new Error(error);

            console.log(body);
        });
        //this.sendSms(mobileNumber, `به چیسکو خوش آمدید\r\nکد ورود:${code}`,)
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

                    // console.log(jsonBody)
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
