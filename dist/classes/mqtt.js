'use strict';var _0x116548=_0x1c42;(function(_0x26482c,_0x5e32dc){var _0x79a561=_0x1c42,_0x8c01f2=_0x26482c();while(!![]){try{var _0x22b6c1=-parseInt(_0x79a561(0x16b))/0x1+-parseInt(_0x79a561(0x156))/0x2+-parseInt(_0x79a561(0x15e))/0x3*(parseInt(_0x79a561(0x158))/0x4)+parseInt(_0x79a561(0x16d))/0x5*(parseInt(_0x79a561(0x15c))/0x6)+parseInt(_0x79a561(0x170))/0x7+parseInt(_0x79a561(0x169))/0x8+parseInt(_0x79a561(0x16a))/0x9;if(_0x22b6c1===_0x5e32dc)break;else _0x8c01f2['push'](_0x8c01f2['shift']());}catch(_0x2713c6){_0x8c01f2['push'](_0x8c01f2['shift']());}}}(_0x5a3a,0x9d1d7));var __createBinding=this&&this[_0x116548(0x166)]||(Object[_0x116548(0x172)]?function(_0x2caa7a,_0x118428,_0x31d262,_0x5d4e86){var _0x319668=_0x116548;if(_0x5d4e86===undefined)_0x5d4e86=_0x31d262;var _0x48f5f8=Object[_0x319668(0x15f)](_0x118428,_0x31d262);(!_0x48f5f8||(_0x319668(0x171)in _0x48f5f8?!_0x118428[_0x319668(0x165)]:_0x48f5f8['writable']||_0x48f5f8[_0x319668(0x163)]))&&(_0x48f5f8={'enumerable':!![],'get':function(){return _0x118428[_0x31d262];}}),Object[_0x319668(0x157)](_0x2caa7a,_0x5d4e86,_0x48f5f8);}:function(_0x170e5f,_0x5591eb,_0x375639,_0x4a40ec){if(_0x4a40ec===undefined)_0x4a40ec=_0x375639;_0x170e5f[_0x4a40ec]=_0x5591eb[_0x375639];}),__setModuleDefault=this&&this['__setModuleDefault']||(Object['create']?function(_0x33eba9,_0x220cc4){var _0x216bde=_0x116548;Object[_0x216bde(0x157)](_0x33eba9,_0x216bde(0x16e),{'enumerable':!![],'value':_0x220cc4});}:function(_0x5f0176,_0x5daa92){var _0x571d93=_0x116548;_0x5f0176[_0x571d93(0x16e)]=_0x5daa92;}),__importStar=this&&this['__importStar']||function(_0x584a59){var _0x37181a=_0x116548;if(_0x584a59&&_0x584a59[_0x37181a(0x165)])return _0x584a59;var _0xf4605e={};if(_0x584a59!=null){for(var _0x33ad8a in _0x584a59)if(_0x33ad8a!==_0x37181a(0x16e)&&Object[_0x37181a(0x150)][_0x37181a(0x168)]['call'](_0x584a59,_0x33ad8a))__createBinding(_0xf4605e,_0x584a59,_0x33ad8a);}return __setModuleDefault(_0xf4605e,_0x584a59),_0xf4605e;};Object[_0x116548(0x157)](exports,_0x116548(0x165),{'value':!![]});const mqtt=__importStar(require(_0x116548(0x151))),constants_1=require(_0x116548(0x14f));function _0x1c42(_0x13f26f,_0x2e474a){var _0x5a3a80=_0x5a3a();return _0x1c42=function(_0x1c4200,_0x48ad83){_0x1c4200=_0x1c4200-0x14f;var _0x15b543=_0x5a3a80[_0x1c4200];return _0x15b543;},_0x1c42(_0x13f26f,_0x2e474a);}class AhpMqtt{constructor(){}static[_0x116548(0x154)](){var _0xc278b0=_0x116548;return!AhpMqtt[_0xc278b0(0x16f)]&&(AhpMqtt[_0xc278b0(0x16f)]=new AhpMqtt()),AhpMqtt[_0xc278b0(0x16f)];}['connect'](){var _0x30beda=_0x116548;const _0x549e47={'clientId':_0x30beda(0x155)+Date[_0x30beda(0x15a)](),'clean':!![],'connectTimeout':0xfa0,'username':_0x30beda(0x15b),'password':_0x30beda(0x164)};this[_0x30beda(0x15d)]=mqtt[_0x30beda(0x153)](constants_1['brokerUrl'],_0x549e47),console[_0x30beda(0x159)]('connect\x20to\x20broker...'),this['client']['on'](_0x30beda(0x160),()=>{var _0x1ed489=_0x30beda;console[_0x1ed489(0x159)](_0x1ed489(0x152));}),this[_0x30beda(0x15d)]['on'](_0x30beda(0x16c),()=>{var _0x1a2e4b=_0x30beda;console['log'](_0x1a2e4b(0x161));}),this[_0x30beda(0x15d)]['on'](_0x30beda(0x153),()=>{var _0x2242aa=_0x30beda;console[_0x2242aa(0x159)]('server\x20connected\x20to\x20the\x20broker');});}[_0x116548(0x162)](_0x15d941){var _0x25b1e0=_0x116548,_0x17eade;(_0x17eade=this[_0x25b1e0(0x15d)])===null||_0x17eade===void 0x0?void 0x0:_0x17eade[_0x25b1e0(0x162)](_0x15d941);}[_0x116548(0x167)](_0x17cf07,_0x51ecb1){var _0x21a3c9;(_0x21a3c9=this['client'])===null||_0x21a3c9===void 0x0?void 0x0:_0x21a3c9['publish'](_0x17cf07,_0x51ecb1);}}exports[_0x116548(0x16e)]=AhpMqtt;function _0x5a3a(){var _0x38e20c=['connect','getInstance','backend_server_','2419286YQybUn','defineProperty','98124yaUaCE','log','now','backend','90390fcuZNt','client','6SyyQji','getOwnPropertyDescriptor','close','disconnect\x20from\x20broker','subscribe','configurable','gZZavYpF','__esModule','__createBinding','publish','hasOwnProperty','389040ahPAqw','15329322slbIlu','1005976pMqFnA','disconnect','45ccMDLJ','default','instance','7145257qEpDfW','get','create','../utility/constants','prototype','mqtt','connection\x20to\x20broker\x20closed'];_0x5a3a=function(){return _0x38e20c;};return _0x5a3a();}