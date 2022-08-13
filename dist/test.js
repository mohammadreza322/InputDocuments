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
    for (let i = 0; i < 10; i++) {
        const newPowerInputs = {
            serialNumber: 'power_ahp_' + i,
            connectors: [
                { portNumber: 1, type: 'power', status: true },
                { portNumber: 2, type: 'power', status: true },
                { portNumber: 3, type: 'power', status: false },
                { portNumber: 4, type: 'power', status: false },
                { portNumber: 1, type: 'usb', status: false },
                { portNumber: 2, type: 'usb', status: true },
            ],
            totalVoltage: 120,
            schedule: [],
        };
        const powerStrip = new device_model_1.PowerStrip(newPowerInputs);
        yield powerStrip.save();
        console.log('done');
    }
    process.exit(0);
}));
//# sourceMappingURL=test.js.map