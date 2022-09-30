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
exports.clientPage = void 0;
const user_entity_1 = __importDefault(require("../entities/user.entity"));
const validator_1 = __importDefault(require("../classes/validator"));
const pagination_1 = require("../classes/pagination");
const clientPage = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const limit = 10;
    let pageNumber = req.query.page;
    if (!pageNumber) {
        pageNumber = "1";
    }
    if (!validator_1.default.isNumber(pageNumber.toString())) {
        pageNumber = "1";
    }
    const page = parseInt(pageNumber.toString());
    const allClientsCounts = yield user_entity_1.default.getCountAllClients();
    const allClients = yield user_entity_1.default.getAllClients(page, limit);
    const pagination = new pagination_1.Pagination(page, limit, allClientsCounts, allClients.length);
    res.locals.scripts.push('/js/lib/persian-date.js', '/js/lib//persian-datepicker.js', '/js/client.js');
    res.locals.styles.push('/css/lib/persian-datepicker.css');
    return res.render('dashboard/main.ejs', {
        title: 'مدریت کاربران',
        page: 'client',
        allClientsCounts,
        allClients,
        pageNumber: page,
        limit,
        pagination
    });
});
exports.clientPage = clientPage;
