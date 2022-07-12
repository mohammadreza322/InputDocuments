"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const mqtt = __importStar(require("mqtt"));
const constants_1 = require("../utility/constants");
class AhpMqtt {
    constructor() { }
    static getInstance() {
        if (!AhpMqtt.instance) {
            AhpMqtt.instance = new AhpMqtt();
        }
        return AhpMqtt.instance;
    }
    connect() {
        const options = {
            clientId: `backend_server_${Date.now()}`,
            clean: true,
            connectTimeout: 4000,
            username: 'backend',
            password: 'gZZavYpF',
        };
        this.client = mqtt.connect(constants_1.brokerUrl, options);
        console.log('connect to broker...');
        this.client.on('close', () => {
            console.log('connection to broker closed');
        });
        this.client.on('disconnect', () => {
            console.log('disconnect from broker');
        });
        this.client.on('connect', () => {
            console.log('server connected to the broker');
        });
    }
    subscribe(topic) {
        var _a;
        (_a = this.client) === null || _a === void 0 ? void 0 : _a.subscribe(topic);
    }
    publish(topic, message) {
        var _a;
        (_a = this.client) === null || _a === void 0 ? void 0 : _a.publish(topic, message);
    }
}
exports.default = AhpMqtt;
//# sourceMappingURL=mqtt.js.map