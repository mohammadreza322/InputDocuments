'use strict';function _0xeb30(_0x1bf2d1,_0x11f258){const _0x210342=_0x2103();return _0xeb30=function(_0xeb3025,_0x378cf8){_0xeb3025=_0xeb3025-0x72;let _0x46575e=_0x210342[_0xeb3025];return _0x46575e;},_0xeb30(_0x1bf2d1,_0x11f258);}const _0x596959=_0xeb30;(function(_0x3f1e90,_0x18237b){const _0x2380f9=_0xeb30,_0x543bb2=_0x3f1e90();while(!![]){try{const _0x389360=parseInt(_0x2380f9(0x82))/0x1+-parseInt(_0x2380f9(0x87))/0x2*(-parseInt(_0x2380f9(0x77))/0x3)+-parseInt(_0x2380f9(0x89))/0x4*(parseInt(_0x2380f9(0x80))/0x5)+parseInt(_0x2380f9(0x88))/0x6*(parseInt(_0x2380f9(0x7f))/0x7)+parseInt(_0x2380f9(0x85))/0x8+parseInt(_0x2380f9(0x84))/0x9+-parseInt(_0x2380f9(0x83))/0xa*(parseInt(_0x2380f9(0x7d))/0xb);if(_0x389360===_0x18237b)break;else _0x543bb2['push'](_0x543bb2['shift']());}catch(_0x391bce){_0x543bb2['push'](_0x543bb2['shift']());}}}(_0x2103,0xa94ea));var __importDefault=this&&this[_0x596959(0x72)]||function(_0x946bac){const _0x55a09f=_0x596959;return _0x946bac&&_0x946bac[_0x55a09f(0x7e)]?_0x946bac:{'default':_0x946bac};};Object['defineProperty'](exports,_0x596959(0x7e),{'value':!![]}),exports[_0x596959(0x86)]=void 0x0;const express_1=__importDefault(require(_0x596959(0x78))),device_controller_1=require('../controller/device.controller'),authorization_1=require(_0x596959(0x73)),router=express_1[_0x596959(0x76)]['Router']();function _0x2103(){const _0x26dd95=['6097592jYjdFW','deviceRouter','28834gEGsml','102drEkls','2147676HNRRFi','use','/save','__importDefault','../middleware/authorization','post','getAuthorization','default','39rYuoeq','express','saveSchedule','/delete-schedule','hasPermission','/schedule','11oiFFTu','__esModule','444073AQrBcP','10hUVwZd','deleteSchedule','929032ZxHRtF','17635490wGEiWo','5163786WtGvyP'];_0x2103=function(){return _0x26dd95;};return _0x2103();}exports['deviceRouter']=router,router[_0x596959(0x8a)]([authorization_1[_0x596959(0x75)],authorization_1[_0x596959(0x7b)]]),router['post'](_0x596959(0x8b),device_controller_1['saveDevice']),router[_0x596959(0x74)]('/delete',device_controller_1['deleteDevice']),router['post'](_0x596959(0x7c),device_controller_1[_0x596959(0x79)]),router[_0x596959(0x74)](_0x596959(0x7a),device_controller_1[_0x596959(0x81)]);