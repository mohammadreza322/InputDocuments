/**
 * @author Amir Hemmateenejad amirhemmateenejad@gmail.com
 * @description
 * class that manage send sms to users
 * @type {SmsProvider}
 */
import axios from "axios";
import fs from "fs";
import path from "path";

export default class SmsProvider {
  _apiKey = "nc7wjMYbZbHhWmDi8fo-6RllrpqrDC1w_6fGJ1j5eUY= ";

  _smsNumber = "+983000505";

  _url = "http://ippanel.com:8080/";

  _moblePhone: string;

  constructor(mobilePhone: string) {
    this._moblePhone = mobilePhone;
  }

  /**
   * @description
   * this method send verification code to user for authorization
   * @param code
   * @param lang
   * @returns {Promise<boolean>}
   */
  sendAuthSms(code: string) {
    //todo fix pattern id with language
    const patternId = "5bh3j6hcd7mp391";
    const patternKey = "verification-code";

    //send sms code to user
    return this._sendWithPattern(patternId, [patternKey], [code]);
  }

  /**
   * @description
   * this method manage send sms process to sms provider host
   * @async
   * @param patternValues
   *
   * if use patterns we can set pattern id and pattern values
   * @param patternId
   * @param patternKey
   * @returns {Promise<boolean>}
   * @private
   */
  async _sendWithPattern(
    patternId?: string,
    patternKey = ["%name"],
    patternValues = ["آرش"]
  ) {
    const params = new URLSearchParams([
      ["apikey", this._apiKey],
      ["fnum", this._smsNumber],
      ["tnum", this._moblePhone],
    ]);

    if (patternId) {
      params.append("pid", patternId);
    }

    patternKey.forEach((value, index) => {
      params.append(`p${index + 1}`, value);
    });

    patternValues.forEach((value, index) => {
      params.append(`v${index + 1}`, value);
    });

    const response = await axios.get(this._url, { params });
    //todo add log function

    if (response.status > 400) {
      fs.writeFile(
        path.join(__dirname, "..", "logs/sms_errors.txt"),

        JSON.stringify(response),
        (err: any) => {
          if (err) {
            console.error(err);
          }
        }
      );
    }

    return response.status === 200 || response.status === 201;
  }
}
