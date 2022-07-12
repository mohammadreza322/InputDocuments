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
const db_1 = __importDefault(require("./config/db"));
const device_model_1 = require("./models/device.model");
(0, db_1.default)().then(() => __awaiter(void 0, void 0, void 0, function* () {
    const coolerDoc = {
        serialNumber: 'cooler_ahp_3',
        schedule: [],
    };
    const a = new device_model_1.Cooler(coolerDoc);
    yield a.save();
    console.log('done');
    process.exit(0);
}));
//# sourceMappingURL=test.js.map