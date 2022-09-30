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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.exitAdmin = exports.dashboardPage = void 0;
const device_entity_1 = __importDefault(require("../entities/device.entity"));
const user_entity_1 = __importDefault(require("../entities/user.entity"));
const sms_provider_1 = __importDefault(require("../classes/sms_provider"));
const dashboardPage = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const countAllPowersInStore = yield device_entity_1.default.getCountAllPowersInStore();
    const countAllCoolersInStore = yield device_entity_1.default.getCountAllCoolersInStore();
    const countAllPowersOutStore = yield device_entity_1.default.getCountAllPowersOutStore();
    const countAllCoolersOutStore = yield device_entity_1.default.getCountAllCoolersOutStore();
    const lastCustomers = yield user_entity_1.default.getLastCustomers();
    res.locals.scripts.push('/js/lib/persian-date.js', '/js/lib//persian-datepicker.js', '/js/dashboard.js');
    res.locals.styles.push('/css/lib/persian-datepicker.css');
    const smsBalance = Math.floor((yield sms_provider_1.default.checkPanelCredit()) / 10).toLocaleString('fa');
    return res.render('dashboard/main.ejs', {
        title: 'داشبرد',
        page: 'dashboard',
        countAllPowersInStore,
        countAllCoolersInStore,
        countAllPowersOutStore,
        countAllCoolersOutStore,
        lastCustomers,
        smsBalance
    });
});
exports.dashboardPage = dashboardPage;
const exitAdmin = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    req.session.isUserLoggedIn = false;
    req.session.userPhone = undefined;
    req.session.loginCode = undefined;
    req.session.loginId = undefined;
    req.session.brokerDetails = undefined;
    return res.redirect('/dashboard/auth');
});
exports.exitAdmin = exitAdmin;
