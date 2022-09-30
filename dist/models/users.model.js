"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const UserSchema = new mongoose_1.Schema({
    fullName: {
        type: String,
    },
    phoneNumber: {
        type: String,
        required: true,
        unique: true,
    },
    registerDate: {
        type: Date,
        default: Date.now,
    },
    role: {
        type: String,
        default: 'user',
    },
    usernameBroker: {
        type: String,
    },
    passwordBroker: {
        type: String,
    },
    address: {
        type: String,
    },
    birthday: {
        type: Date,
    },
    enable: {
        type: Boolean,
        default: true
    }
}, { toJSON: { virtuals: true } });
const Users = (0, mongoose_1.model)('User', UserSchema);
exports.default = Users;
