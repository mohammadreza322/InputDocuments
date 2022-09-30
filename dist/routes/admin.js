"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.adminRoute = void 0;
const express_1 = __importDefault(require("express"));
const admin_pageview_1 = require("../page_view/admin.pageview");
const user_controller_1 = require("../controller/user.controller");
const router = express_1.default.Router();
exports.adminRoute = router;
router.get('/', admin_pageview_1.adminPage);
router.post('/add', user_controller_1.addAdmin);
router.post('/edit', user_controller_1.editAdmin);
router.post('/delete', user_controller_1.deleteAdmin);
router.post('/current', user_controller_1.editCurrentAdmin);
