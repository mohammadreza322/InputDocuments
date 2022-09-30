"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.otpPage = exports.loginPage = void 0;
const loginPage = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    if (req.session.isUserLoggedIn) {
        console.log(req.session.isUserLoggedIn);
        return res.redirect('/dashboard');
    }
    res.locals.scripts.push('/js/login.js');
    return res.render('auth/main.ejs', {
        title: 'ورود به چیسکو',
        page: 'login'
    });
});
exports.loginPage = loginPage;
const otpPage = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    if (req.session.isUserLoggedIn) {
        return res.redirect('/dashboard');
    }
    if (!req.session.userPhone || !req.session.loginCode) {
        return res.redirect('/dashboard/auth');
    }
    res.locals.scripts.push('/js/otp.js');
    return res.render('auth/main.ejs', {
        title: 'رمز یکبار مصرف',
        page: 'otp',
        phone: req.session.userPhone,
        id: req.session.loginId
    });
});
exports.otpPage = otpPage;
