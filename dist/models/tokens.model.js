"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const tokenSchema = new mongoose_1.Schema({
    token: {
        type: String,
        required: true,
    },
    refreshToken: {
        type: String,
        required: true,
    },
    agent: {
        type: String,
        required: true,
    },
    time: {
        type: Date,
        required: true,
        default: Date.now,
    },
    user: {
        type: mongoose_1.Types.ObjectId,
        required: true,
        ref: 'User',
    },
});
const Token = (0, mongoose_1.model)('Tokens', tokenSchema);
exports.default = Token;
//# sourceMappingURL=tokens.model.js.map