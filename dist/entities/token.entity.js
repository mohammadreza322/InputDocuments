'use strict';function _0x3663(){const _0x372b90=['12gIApfr','throw','__awaiter','jsonwebtoken','accessTokenExpireTime','650yHqRUo','72100NbBshc','544624tLwxHK','3622283Nzdkfq','12jABRKs','defineProperty','../models/tokens.model','removeOldToken','toString','9gogpch','removeAllUserTokens','done','apply','../utility/constants','default','16138837NIIujs','deleteMany','deleteOne','createToken','588502VKeeIM','4948vTjEcm','then','generateToken','__importDefault','3400896TkIbzR','9hmfgiZ','sign','refreshTokenExpireTime','jsonWebTokenSecretKey','__esModule','value','396RNcOEI'];_0x3663=function(){return _0x372b90;};return _0x3663();}const _0x2a0b51=_0x2bfb;(function(_0x5f00c0,_0x235131){const _0x4cbd94=_0x2bfb,_0x34bf8d=_0x5f00c0();while(!![]){try{const _0xed49da=-parseInt(_0x4cbd94(0x10d))/0x1+-parseInt(_0x4cbd94(0x11e))/0x2*(parseInt(_0x4cbd94(0x114))/0x3)+-parseInt(_0x4cbd94(0x11f))/0x4*(parseInt(_0x4cbd94(0x10b))/0x5)+-parseInt(_0x4cbd94(0x10f))/0x6*(-parseInt(_0x4cbd94(0x10e))/0x7)+parseInt(_0x4cbd94(0x123))/0x8*(-parseInt(_0x4cbd94(0x124))/0x9)+parseInt(_0x4cbd94(0x10c))/0xa*(parseInt(_0x4cbd94(0x12a))/0xb)+-parseInt(_0x4cbd94(0x12b))/0xc*(-parseInt(_0x4cbd94(0x11a))/0xd);if(_0xed49da===_0x235131)break;else _0x34bf8d['push'](_0x34bf8d['shift']());}catch(_0x4af821){_0x34bf8d['push'](_0x34bf8d['shift']());}}}(_0x3663,0x7f998));var __awaiter=this&&this[_0x2a0b51(0x12d)]||function(_0x37d460,_0xb3a686,_0x4636a0,_0xcf2eab){function _0x5f1df3(_0x3b0208){return _0x3b0208 instanceof _0x4636a0?_0x3b0208:new _0x4636a0(function(_0x1ac6ef){_0x1ac6ef(_0x3b0208);});}return new(_0x4636a0||(_0x4636a0=Promise))(function(_0x64aadb,_0x4fbd8b){const _0x448662=_0x2bfb;function _0x241039(_0x1e7838){try{_0xd7b69(_0xcf2eab['next'](_0x1e7838));}catch(_0x28f5fc){_0x4fbd8b(_0x28f5fc);}}function _0x33dd5b(_0x24936f){const _0x581d99=_0x2bfb;try{_0xd7b69(_0xcf2eab[_0x581d99(0x12c)](_0x24936f));}catch(_0x307a0c){_0x4fbd8b(_0x307a0c);}}function _0xd7b69(_0xedf1ae){const _0x36043f=_0x2bfb;_0xedf1ae[_0x36043f(0x116)]?_0x64aadb(_0xedf1ae[_0x36043f(0x129)]):_0x5f1df3(_0xedf1ae[_0x36043f(0x129)])[_0x36043f(0x120)](_0x241039,_0x33dd5b);}_0xd7b69((_0xcf2eab=_0xcf2eab[_0x448662(0x117)](_0x37d460,_0xb3a686||[]))['next']());});},__importDefault=this&&this[_0x2a0b51(0x122)]||function(_0x40e77a){const _0x5936ff=_0x2a0b51;return _0x40e77a&&_0x40e77a[_0x5936ff(0x128)]?_0x40e77a:{'default':_0x40e77a};};Object[_0x2a0b51(0x110)](exports,_0x2a0b51(0x128),{'value':!![]});function _0x2bfb(_0x512d6e,_0x2c33d8){const _0x366398=_0x3663();return _0x2bfb=function(_0x2bfb3c,_0x518ab4){_0x2bfb3c=_0x2bfb3c-0x10a;let _0x55dc15=_0x366398[_0x2bfb3c];return _0x55dc15;},_0x2bfb(_0x512d6e,_0x2c33d8);}const constants_1=require(_0x2a0b51(0x118)),tokens_model_1=__importDefault(require(_0x2a0b51(0x111))),jsonwebtoken_1=require(_0x2a0b51(0x12e));class TokenEntity{static[_0x2a0b51(0x121)](_0x2938e7){const _0x4c8d2f=_0x2a0b51,_0x5ec56a=(0x0,jsonwebtoken_1[_0x4c8d2f(0x125)])({'id':_0x2938e7},constants_1['jsonWebTokenSecretKey'],{'expiresIn':constants_1[_0x4c8d2f(0x10a)]}),_0x234ce1=(0x0,jsonwebtoken_1[_0x4c8d2f(0x125)])({'id':_0x2938e7},constants_1[_0x4c8d2f(0x127)],{'expiresIn':constants_1[_0x4c8d2f(0x126)]});return{'accessToken':_0x5ec56a,'refreshToken':_0x234ce1};}static[_0x2a0b51(0x11d)](_0x3be302,_0x11dfbb){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x1c9868=_0x2bfb,{accessToken:_0x531acd,refreshToken:_0x5838b8}=this[_0x1c9868(0x121)](_0x3be302[_0x1c9868(0x113)]());return yield tokens_model_1['default']['insertMany']({'token':_0x531acd,'refreshToken':_0x5838b8,'agent':_0x11dfbb,'user':_0x3be302}),{'accessToken':_0x531acd,'refreshToken':_0x5838b8};});}static[_0x2a0b51(0x112)](_0x40b059,_0x5b7a12){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x3db90e=_0x2bfb;yield tokens_model_1['default'][_0x3db90e(0x11c)]({'agent':_0x5b7a12,'user':_0x40b059});});}static[_0x2a0b51(0x115)](_0x10ecaf){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x10a1f6=_0x2bfb;yield tokens_model_1[_0x10a1f6(0x119)][_0x10a1f6(0x11b)]({'user':_0x10ecaf});});}}exports['default']=TokenEntity;