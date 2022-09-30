"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.customerRoute = void 0;
const express_1 = __importDefault(require("express"));
const customer_controller_1 = require("../controller/customer.controller");
const clients_pageview_1 = require("../page_view/clients.pageview");
const router = express_1.default.Router();
exports.customerRoute = router;
router.post('/delete', customer_controller_1.deleteCustomer);
router.post('/edit', customer_controller_1.editUser);
router.get('/', clients_pageview_1.clientPage);
