"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Cooler = exports.PowerStrip = void 0;
const mongoose_1 = require("mongoose");
const scheduleDeviceDefaultSchema = {
    name: {
        type: 'string',
    },
    start: {
        type: 'string',
    },
    end: {
        type: 'string',
    },
    enable: {
        type: 'boolean',
        default: true,
    },
    repeat: {
        default: [],
        type: [{ type: String }],
    },
};
const defaultDeviceSchema = {
    serialNumber: {
        type: 'string',
        required: true,
    },
    name: {
        type: 'string',
    },
    category: {
        type: 'string',
    },
    createAt: {
        type: Date,
        default: Date.now
    },
    registerAt: {
        type: Date,
    },
    owner: {
        type: mongoose_1.Types.ObjectId,
    },
    deviceLastConnection: {
        type: 'string',
    },
    password: {
        type: 'string',
    },
    insertedUser: {
        type: mongoose_1.Types.ObjectId,
    }
};
const powerStripSchema = new mongoose_1.Schema(Object.assign(Object.assign({}, defaultDeviceSchema), { connectors: {
        type: [
            {
                status: Boolean,
                name: String,
                connectorType: {
                    type: String,
                    enum: ['usb', 'power'],
                },
                connectorId: Number,
            },
        ],
        default: [],
    }, totalVoltage: {
        type: Number,
        default: 0,
    }, schedule: {
        type: [
            {
                port: Number,
                name: String,
                start: String,
                end: String,
                enable: {
                    type: Boolean,
                    default: true,
                },
                repeat: {
                    type: [{ type: String }],
                    default: [],
                },
            },
        ],
        default: [],
    } }));
exports.PowerStrip = (0, mongoose_1.model)('PowerStrip', powerStripSchema);
const coolerSchema = new mongoose_1.Schema(Object.assign(Object.assign({}, defaultDeviceSchema), { brand: {
        type: String,
    }, model: {
        type: String,
    }, temp: {
        type: Number,
        default: 20,
    }, mode: {
        type: String,
        default: 'Auto',
    }, horizontalSwing: {
        type: String,
        default: 'Auto',
    }, verticalSwing: {
        type: String,
        default: 'Auto',
    }, fan: {
        type: String,
        default: 'Auto',
    }, timer: {
        type: String,
        default: 'Off',
    }, schedule: {
        type: [scheduleDeviceDefaultSchema],
        default: [],
    }, power: {
        type: Boolean,
        default: true,
    } }));
exports.Cooler = (0, mongoose_1.model)('Cooler', coolerSchema);
