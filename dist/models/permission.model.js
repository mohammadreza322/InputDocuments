"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const permissionSchema = new mongoose_1.Schema({
    role: {
        type: 'string',
        required: true,
        trim: true,
    },
    GET: [
        {
            type: String,
        },
    ],
    POST: [
        {
            type: String,
        },
    ],
    PUT: [{ type: String }],
    DELETE: [{ type: String }],
});
const Permission = (0, mongoose_1.model)('Permission', permissionSchema);
exports.default = Permission;
//# sourceMappingURL=permission.model.js.map