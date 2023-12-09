import 'express-session';
import {Request} from 'express'


declare module 'express-session' {
    interface SessionData {
        userPhone?:string;
        isUserLoggedIn?: boolean;
        loginCode?:string,
        loginId?:string,
        brokerDetails?:string
    }
}
