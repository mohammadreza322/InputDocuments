"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const logSchema = new mongoose_1.Schema({
    date: {
        type: Date,
        default: Date.now
    },
    message: {
        type: String,
    },
    logId: {
        type: mongoose_1.Types.ObjectId,
    }
});
const Logs = (0, mongoose_1.model)('Logs', logSchema);
exports.default = Logs;
