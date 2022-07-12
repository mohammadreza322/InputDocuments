"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.userRouter = void 0;
const express_1 = __importDefault(require("express"));
const user_controller_1 = require("../controller/user.controller");
const authorization_1 = require("../middleware/authorization");
const router = express_1.default.Router();
exports.userRouter = router;
router.use([authorization_1.getAuthorization, authorization_1.hasPermission]);
router.post('/get-name', user_controller_1.getFullName);
router.put('/edit', user_controller_1.editUserProfile);
router.get('/', user_controller_1.getUserDetails);
//# sourceMappingURL=user.router.js.map