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
const broker_provider_1 = __importDefault(require("./classes/broker_provider"));
const db_1 = __importDefault(require("./config/db"));
(0, db_1.default)().then(() => __awaiter(void 0, void 0, void 0, function* () {
    console.log(yield broker_provider_1.default.userExist('06dc732cc261b06a640268926fe290d55f0928ea'));
    console.log("done");
    process.exit(0);
}));
