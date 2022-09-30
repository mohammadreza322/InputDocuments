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
exports.adminPage = void 0;
const user_entity_1 = __importDefault(require("../entities/user.entity"));
const validator_1 = __importDefault(require("../classes/validator"));
const pagination_1 = require("../classes/pagination");
const adminPage = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const countAllAdmins = yield user_entity_1.default.getCountAllAdmins();
    const limit = 10;
    let pageNumber = req.query.page;
    if (!pageNumber) {
        pageNumber = "1";
    }
    if (!validator_1.default.isNumber(pageNumber.toString())) {
        pageNumber = "1";
    }
    const page = parseInt(pageNumber.toString());
    const allAdmins = yield user_entity_1.default.getAllAdmins(page, limit);
    const pagination = new pagination_1.Pagination(page, limit, countAllAdmins, allAdmins.length);
    res.locals.scripts.push('/js/admin.js');
    return res.render('dashboard/main.ejs', {
        title: 'مدیریت مدیرها',
        page: 'admin',
        countAllAdmins,
        allAdmins,
        pageNumber: page,
        limit,
        pagination
    });
});
exports.adminPage = adminPage;
