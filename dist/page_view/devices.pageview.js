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
exports.storeHouse = exports.devicesPage = void 0;
const device_entity_1 = __importDefault(require("../entities/device.entity"));
const validator_1 = __importDefault(require("../classes/validator"));
const pagination_1 = require("../classes/pagination");
const devicesPage = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let { activeTab, coolerPage, powerPage } = req.query;
    if (!activeTab) {
        activeTab = 'cooler';
    }
    activeTab = activeTab.toString();
    if (!['cooler', 'power'].includes(activeTab)) {
        activeTab = 'cooler';
    }
    req.query.activeTab = activeTab;
    if (!coolerPage) {
        coolerPage = "1";
    }
    if (!validator_1.default.isNumber(coolerPage.toString())) {
        coolerPage = "1";
    }
    let coolerPageNumber = parseInt(coolerPage.toString());
    if (coolerPageNumber < 1) {
        coolerPageNumber = 1;
    }
    if (!powerPage) {
        powerPage = "1";
    }
    if (!validator_1.default.isNumber(powerPage.toString())) {
        powerPage = "1";
    }
    let powerPageNumber = parseInt(powerPage.toString());
    if (powerPageNumber < 1) {
        powerPageNumber = 1;
    }
    const limit = 10;
    const countAllPowers = yield device_entity_1.default.getCountAllPowersOutStore();
    const countAllCoolers = yield device_entity_1.default.getCountAllCoolersOutStore();
    const allPowers = yield device_entity_1.default.getAllPowers(powerPageNumber, limit);
    const powerPagination = new pagination_1.Pagination(powerPageNumber, limit, countAllPowers, allPowers.length, "powerPage");
    const allCoolers = yield device_entity_1.default.getAllCoolers(coolerPageNumber, limit);
    const coolerPagination = new pagination_1.Pagination(coolerPageNumber, limit, countAllCoolers, allCoolers.length, "coolerPage");
    res.locals.queries = req.query;
    res.locals.scripts.push('/js/device.js');
    return res.render('dashboard/main.ejs', {
        title: 'مدیریت دستگاه ها',
        page: 'devices',
        countAllPowers,
        countAllCoolers,
        allPowers,
        powerPagination,
        activeTab,
        powerPageNumber,
        limit,
        allCoolers,
        coolerPagination,
        coolerPageNumber
    });
});
exports.devicesPage = devicesPage;
const storeHouse = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let { activeTab, coolerPage, powerPage } = req.query;
    if (!activeTab) {
        activeTab = 'cooler';
    }
    activeTab = activeTab.toString();
    if (!['cooler', 'power'].includes(activeTab)) {
        activeTab = 'cooler';
    }
    req.query.activeTab = activeTab;
    if (!coolerPage) {
        coolerPage = "1";
    }
    if (!validator_1.default.isNumber(coolerPage.toString())) {
        coolerPage = "1";
    }
    let coolerPageNumber = parseInt(coolerPage.toString());
    if (coolerPageNumber < 1) {
        coolerPageNumber = 1;
    }
    if (!powerPage) {
        powerPage = "1";
    }
    if (!validator_1.default.isNumber(powerPage.toString())) {
        powerPage = "1";
    }
    let powerPageNumber = parseInt(powerPage.toString());
    if (powerPageNumber < 1) {
        powerPageNumber = 1;
    }
    const limit = 10;
    const countAllPowers = yield device_entity_1.default.getCountAllPowersInStore();
    const countAllCoolers = yield device_entity_1.default.getCountAllCoolersInStore();
    const allPowers = yield device_entity_1.default.getAllPowersInStore(powerPageNumber, limit);
    const powerPagination = new pagination_1.Pagination(powerPageNumber, limit, countAllPowers, allPowers.length, "powerPage");
    const allCoolers = yield device_entity_1.default.getAllCoolersInStore(coolerPageNumber, limit);
    const coolerPagination = new pagination_1.Pagination(coolerPageNumber, limit, countAllCoolers, allCoolers.length, "coolerPage");
    res.locals.queries = req.query;
    res.locals.scripts.push('/js/storehouse.js');
    res.render('dashboard/main.ejs', {
        title: 'انبار',
        page: 'storehouse',
        countAllPowers,
        countAllCoolers,
        allPowers,
        allCoolers,
        powerPagination,
        coolerPagination,
        activeTab,
        powerPageNumber,
        coolerPageNumber,
        limit
    });
});
exports.storeHouse = storeHouse;
