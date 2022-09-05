"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const body_parser_1 = require("body-parser");
const api_router_1 = require("./routes/api.router");
const db_1 = __importDefault(require("./config/db"));
require("./types/global.type");
const mqtt_1 = __importDefault(require("./classes/mqtt"));
const cors_1 = __importDefault(require("cors"));
process.env.TZ = 'Asia/Tehran';
const app = (0, express_1.default)();
app.use((0, cors_1.default)());
app.use((0, body_parser_1.json)());
app.use((_, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE'); // If needed
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type,x-auth-token'); // If needed
    res.setHeader('Access-Control-Allow-Credentials', "true");
    return next();
});
app.use('/api', api_router_1.apiRouter);
app.use('/', (_, res) => {
    return res.json({ message: 'ok server' });
});
const PORT = process.env.PORT || 8800;
(0, db_1.default)().then(() => {
    console.log('mongo database connected');
    mqtt_1.default.getInstance().connect();
    app.listen(PORT, () => console.log(`server start at ${PORT}`));
});
//# sourceMappingURL=index.js.map