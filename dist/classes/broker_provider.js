'use strict';const _0x542cc5=_0x37b3;(function(_0x4a4e8b,_0x162e8b){const _0x3ac1ec=_0x37b3,_0x2dd347=_0x4a4e8b();while(!![]){try{const _0xecc187=-parseInt(_0x3ac1ec(0xa2))/0x1*(parseInt(_0x3ac1ec(0x98))/0x2)+-parseInt(_0x3ac1ec(0x99))/0x3*(-parseInt(_0x3ac1ec(0xb9))/0x4)+parseInt(_0x3ac1ec(0xad))/0x5+-parseInt(_0x3ac1ec(0xa0))/0x6*(parseInt(_0x3ac1ec(0xb1))/0x7)+parseInt(_0x3ac1ec(0xb8))/0x8+parseInt(_0x3ac1ec(0xb2))/0x9+parseInt(_0x3ac1ec(0xb6))/0xa*(-parseInt(_0x3ac1ec(0xaa))/0xb);if(_0xecc187===_0x162e8b)break;else _0x2dd347['push'](_0x2dd347['shift']());}catch(_0x5afb30){_0x2dd347['push'](_0x2dd347['shift']());}}}(_0x3233,0xc5276));var __awaiter=this&&this[_0x542cc5(0x9a)]||function(_0x288562,_0xe663fc,_0x55c700,_0x2617f0){function _0x2f1bdd(_0x429cb7){return _0x429cb7 instanceof _0x55c700?_0x429cb7:new _0x55c700(function(_0x24829f){_0x24829f(_0x429cb7);});}return new(_0x55c700||(_0x55c700=Promise))(function(_0x38038b,_0xffaccf){const _0x5934df=_0x37b3;function _0x2b5030(_0x8e95ca){try{_0x29b83e(_0x2617f0['next'](_0x8e95ca));}catch(_0x3de889){_0xffaccf(_0x3de889);}}function _0x1787cf(_0x6d2c7d){const _0x58915d=_0x37b3;try{_0x29b83e(_0x2617f0[_0x58915d(0xa1)](_0x6d2c7d));}catch(_0x2ef0d3){_0xffaccf(_0x2ef0d3);}}function _0x29b83e(_0x549945){const _0x4a48f0=_0x37b3;_0x549945['done']?_0x38038b(_0x549945[_0x4a48f0(0x9e)]):_0x2f1bdd(_0x549945[_0x4a48f0(0x9e)])[_0x4a48f0(0xa7)](_0x2b5030,_0x1787cf);}_0x29b83e((_0x2617f0=_0x2617f0[_0x5934df(0xa5)](_0x288562,_0xe663fc||[]))['next']());});};Object[_0x542cc5(0xa6)](exports,_0x542cc5(0xae),{'value':!![]});function _0x37b3(_0x46bf91,_0x450489){const _0x32331e=_0x3233();return _0x37b3=function(_0x37b3e2,_0x1bd44a){_0x37b3e2=_0x37b3e2-0x96;let _0x3f55fa=_0x32331e[_0x37b3e2];return _0x3f55fa;},_0x37b3(_0x46bf91,_0x450489);}const request=require('request'),constants_1=require(_0x542cc5(0x9d));function _0x3233(){const _0x44f8cb=['body','stringify','1080EavGnu','authorization','4773128UibmTv','6031076NZREZE','POST','log','484xreKiQ','3ZgwJPq','__awaiter','GET','parse','../utility/constants','value','error','18moHauS','throw','6049MKXcOt','/auth_username','/clients/','apply','defineProperty','then','DELETE','inside\x20check\x20mnesia\x20user','11539MlzczD','default','data','3047290WlXGJV','__esModule','application/json','/auth_username/','2161537fBXLhe','5374773GceVJp','brokerUrlAPI'];_0x3233=function(){return _0x44f8cb;};return _0x3233();}class BrokerProvider{static['addUserToMnesia'](_0x4b3123,_0x193a82){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x7d181b=_0x37b3;var _0x13ad19={'method':_0x7d181b(0x96),'url':constants_1[_0x7d181b(0xb3)]+_0x7d181b(0xa3),'headers':{'Authorization':this[_0x7d181b(0xb7)],'Content-Type':_0x7d181b(0xaf)},'body':JSON[_0x7d181b(0xb5)]({'username':_0x4b3123,'password':_0x193a82})};return new Promise((_0x48f658,_0xfffa2d)=>{request(_0x13ad19,function(_0x4b5011,_0x3ce8cd){const _0x188d9d=_0x37b3;if(_0x4b5011)return console[_0x188d9d(0x9f)]('inside\x20add\x20mnesia\x20user'),console[_0x188d9d(0x9f)](_0x4b5011),_0x48f658(![]);return _0x48f658(!![]);});});});}static['userExist'](_0x246d09){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x319d96=_0x37b3,_0x48ab4b={'method':_0x319d96(0x9b),'url':constants_1[_0x319d96(0xb3)]+_0x319d96(0xb0)+_0x246d09,'headers':{'Authorization':this[_0x319d96(0xb7)]}};return new Promise(function(_0x195f54,_0x306e45){request(_0x48ab4b,function(_0x5a9018,_0x54ec11){const _0x3596fc=_0x37b3;if(_0x5a9018)return console[_0x3596fc(0x9f)](_0x3596fc(0xa9)),console[_0x3596fc(0x9f)](_0x5a9018),_0x195f54(![]);console[_0x3596fc(0x97)](_0x54ec11[_0x3596fc(0xb4)]);const _0x133e56=JSON[_0x3596fc(0x9c)](_0x54ec11[_0x3596fc(0xb4)]);if(_0x133e56[_0x3596fc(0xac)]){if(_0x133e56['data']['username'])return _0x195f54(!![]);return _0x195f54(![]);}return _0x195f54(![]);});});});}static['kickDevice'](_0x1e358b){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x29d06c=_0x37b3,_0x19a089={'method':_0x29d06c(0xa8),'url':constants_1[_0x29d06c(0xb3)]+_0x29d06c(0xa4)+_0x1e358b,'headers':{'Authorization':this[_0x29d06c(0xb7)]}};return new Promise((_0x5ccb7a,_0x19c664)=>{request(_0x19a089,function(_0x51db1e,_0xcdf924){const _0x378158=_0x37b3;if(_0x51db1e)return console[_0x378158(0x9f)]('inside\x20check\x20kick\x20mnesia'),console[_0x378158(0x9f)](_0x51db1e),_0x5ccb7a(![]);return console[_0x378158(0x97)](_0xcdf924[_0x378158(0xb4)]),_0x5ccb7a(!![]);});});});}}exports[_0x542cc5(0xab)]=BrokerProvider,BrokerProvider[_0x542cc5(0xb7)]='Basic\x20MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw==';