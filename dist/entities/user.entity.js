'use strict';const _0x4cd8d6=_0xf637;(function(_0x199130,_0x2ac4eb){const _0x8c52cb=_0xf637,_0x35a39d=_0x199130();while(!![]){try{const _0x4f5e62=-parseInt(_0x8c52cb(0x1a4))/0x1*(-parseInt(_0x8c52cb(0x19c))/0x2)+-parseInt(_0x8c52cb(0x195))/0x3+parseInt(_0x8c52cb(0x180))/0x4+parseInt(_0x8c52cb(0x1a0))/0x5*(-parseInt(_0x8c52cb(0x19a))/0x6)+parseInt(_0x8c52cb(0x186))/0x7*(-parseInt(_0x8c52cb(0x1c4))/0x8)+parseInt(_0x8c52cb(0x1b1))/0x9+parseInt(_0x8c52cb(0x1c2))/0xa*(parseInt(_0x8c52cb(0x1aa))/0xb);if(_0x4f5e62===_0x2ac4eb)break;else _0x35a39d['push'](_0x35a39d['shift']());}catch(_0x4c6022){_0x35a39d['push'](_0x35a39d['shift']());}}}(_0x6f11,0x3237c));var __awaiter=this&&this[_0x4cd8d6(0x16d)]||function(_0xa8d1d7,_0x366ed1,_0x14891b,_0x4c9472){function _0xc2fb04(_0x5ca57b){return _0x5ca57b instanceof _0x14891b?_0x5ca57b:new _0x14891b(function(_0x2e175d){_0x2e175d(_0x5ca57b);});}return new(_0x14891b||(_0x14891b=Promise))(function(_0x497950,_0x2371a9){const _0x415633=_0xf637;function _0x42e1ce(_0x193d26){const _0x403887=_0xf637;try{_0x4b3805(_0x4c9472[_0x403887(0x169)](_0x193d26));}catch(_0x1e6a72){_0x2371a9(_0x1e6a72);}}function _0x47d4e8(_0x384747){const _0x1036cb=_0xf637;try{_0x4b3805(_0x4c9472[_0x1036cb(0x172)](_0x384747));}catch(_0x37ebd2){_0x2371a9(_0x37ebd2);}}function _0x4b3805(_0x4f498e){const _0x4cc232=_0xf637;_0x4f498e['done']?_0x497950(_0x4f498e[_0x4cc232(0x1b2)]):_0xc2fb04(_0x4f498e[_0x4cc232(0x1b2)])[_0x4cc232(0x196)](_0x42e1ce,_0x47d4e8);}_0x4b3805((_0x4c9472=_0x4c9472[_0x415633(0x19f)](_0xa8d1d7,_0x366ed1||[]))[_0x415633(0x169)]());});},__importDefault=this&&this['__importDefault']||function(_0x20c8f4){return _0x20c8f4&&_0x20c8f4['__esModule']?_0x20c8f4:{'default':_0x20c8f4};};Object[_0x4cd8d6(0x184)](exports,_0x4cd8d6(0x19b),{'value':!![]});function _0xf637(_0x4b270f,_0x472267){const _0x6f1196=_0x6f11();return _0xf637=function(_0xf637c2,_0x5cbe61){_0xf637c2=_0xf637c2-0x169;let _0xbfa334=_0x6f1196[_0xf637c2];return _0xbfa334;},_0xf637(_0x4b270f,_0x472267);}const jsonwebtoken_1=require('jsonwebtoken'),broker_provider_1=__importDefault(require(_0x4cd8d6(0x1ad))),users_model_1=__importDefault(require(_0x4cd8d6(0x16f))),constants_1=require('../utility/constants'),crypto_js_1=require(_0x4cd8d6(0x1b0)),device_entity_1=__importDefault(require(_0x4cd8d6(0x17a))),persian_date_1=__importDefault(require('@alireza-ab/persian-date')),convert_1=require('../classes/convert'),logs_entity_1=__importDefault(require('./logs.entity'));function _0x6f11(){const _0x31d06b=['editCurrentAdmin','getAllAdmins','assign','registerDate','log','getFullYear','getLastCustomers','isUserCanLoginInDashboard','map','deleteAdmin','push','getHours','checkPhoneNumberWithId','56955gEtfbr','then','customer_service','addUserToMnesia','adminRoleTranslate','726QBOWsz','__esModule','56488FcRDTQ','stringify','jsonWebTokenSecretKey','apply','10385weNbPW','getUserInformationWithPhoneNumber','date','userExist','1eNRcen','enable','getTime','role','غیرفعال','phoneNumber','1287ZZEYSE','skip','calendar','../classes/broker_provider','trim','sort','crypto-js','1430109tRmjdu','value','فعال','removeUser','sign','error','default','ceil','length','ندارد','getUserInformation','getDate','fullName','toString','toObject','findOne','updateOne','39960UDCrtx','getAllClients','1695832mhLtuk','getAllDevicesCount','deleteOne','next','datetime','warehouse','findById','__awaiter','message','../models/users.model','_id','birthday','throw','limit','find','address','setUserDetailsWithPhoneNUmber','insertMany','SHA1','inside\x20user\x20entity\x20set\x20user\x20details','./device.entity','countDocuments','user','jalali','setUserDetails','admin','133184oxfeSQ','getLogs','getBrokerUserNamePassword','getMonth','defineProperty','editAdmin','7QQWKmf','checkPhoneNumberExists'];_0x6f11=function(){return _0x31d06b;};return _0x6f11();}class UserEntity{static[_0x4cd8d6(0x17e)](_0x64bb3f,_0xa6722f,_0x40df36,_0x4c8abe){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x11466d=_0xf637;try{return yield users_model_1[_0x11466d(0x1b7)][_0x11466d(0x1c1)]({'_id':_0x64bb3f},{'$set':{'fullName':_0xa6722f,'birthday':_0x40df36,'address':_0x4c8abe}}),!![];}catch(_0xf402da){return console[_0x11466d(0x1b6)]('inside\x20user\x20entity\x20set\x20user\x20details'),console[_0x11466d(0x1b6)](_0xf402da),![];}});}static[_0x4cd8d6(0x176)](_0x118776,_0x294589,_0x43c874,_0x2200cc,_0x2bef29){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x4d0e73=_0xf637;try{return yield users_model_1['default'][_0x4d0e73(0x1c1)]({'_id':_0x118776},{'$set':{'fullName':_0x294589,'birthday':_0x2200cc,'address':_0x2bef29,'phoneNumber':_0x43c874}}),!![];}catch(_0x568a86){return console['error'](_0x4d0e73(0x179)),console[_0x4d0e73(0x1b6)](_0x568a86),![];}});}static[_0x4cd8d6(0x182)](_0x4b00b2){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x1faf43=_0xf637,_0xfb628c=yield users_model_1[_0x1faf43(0x1b7)]['findOne']({'_id':_0x4b00b2}),_0x395a06=(0x0,crypto_js_1[_0x1faf43(0x178)])(_0xfb628c['registerDate'][_0x1faf43(0x1be)]()+_0xfb628c[_0x1faf43(0x170)][_0x1faf43(0x1be)]())[_0x1faf43(0x1be)](),_0x257b1e=(0x0,crypto_js_1[_0x1faf43(0x178)])(_0xfb628c['registerDate'][_0x1faf43(0x1be)]()+(_0xfb628c===null||_0xfb628c===void 0x0?void 0x0:_0xfb628c[_0x1faf43(0x1a9)][_0x1faf43(0x1be)]()))['toString'](),_0x5377bb=yield broker_provider_1[_0x1faf43(0x1b7)][_0x1faf43(0x1a3)](_0x395a06);return!_0x5377bb&&(console[_0x1faf43(0x18c)]('add\x20user\x20mnesia'),yield broker_provider_1[_0x1faf43(0x1b7)][_0x1faf43(0x198)](_0x395a06,_0x257b1e)),(0x0,jsonwebtoken_1[_0x1faf43(0x1b5)])({'usernameBroker':_0x395a06,'passwordBroker':_0x257b1e},constants_1[_0x1faf43(0x19e)],{'expiresIn':'5m'});});}static[_0x4cd8d6(0x1bb)](_0x25db85){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x174adb=_0xf637,_0x50feca=yield users_model_1[_0x174adb(0x1b7)][_0x174adb(0x16c)](_0x25db85);if(!_0x50feca)return null;let _0x1713ea=null;return _0x50feca[_0x174adb(0x171)]&&(_0x1713ea=Math[_0x174adb(0x1b8)](_0x50feca[_0x174adb(0x171)][_0x174adb(0x1a6)]()/0x3e8)),{'phoneNumber':_0x50feca[_0x174adb(0x1a9)],'fullName':_0x50feca[_0x174adb(0x1bd)],'address':_0x50feca[_0x174adb(0x175)],'birthday':_0x1713ea};});}static[_0x4cd8d6(0x1a1)](_0x3ec54a){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x12fc4e=_0xf637,_0x54a402=yield users_model_1['default'][_0x12fc4e(0x1c0)]({'phoneNumber':_0x3ec54a});let _0x4143c9=null;return _0x54a402[_0x12fc4e(0x171)]&&(_0x4143c9=Math[_0x12fc4e(0x1b8)](_0x54a402['birthday']['getTime']()/0x3e8)),{'phoneNumber':_0x54a402['phoneNumber'],'fullName':_0x54a402['fullName'],'address':_0x54a402['address'],'birthday':_0x4143c9,'role':_0x54a402[_0x12fc4e(0x1a7)],'id':_0x54a402['id'],'registerDate':_0x54a402[_0x12fc4e(0x18b)]};});}static[_0x4cd8d6(0x18f)](_0x135109){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x14c331=_0xf637,_0x56559f=yield users_model_1['default']['findById'](_0x135109);if(!_0x56559f)return![];if(_0x56559f['role']==_0x14c331(0x17c))return![];if(!_0x56559f[_0x14c331(0x1a5)])return![];return!![];});}static[_0x4cd8d6(0x18e)](){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x352cee=_0xf637,_0x371782=yield users_model_1[_0x352cee(0x1b7)][_0x352cee(0x174)]({'role':_0x352cee(0x17c)})['sort']({'registerDate':-0x1})['limit'](0xa),_0x12969a=[];for(const _0x1d7ca6 of _0x371782){const _0x2f8b2a=yield device_entity_1[_0x352cee(0x1b7)][_0x352cee(0x1c5)](_0x1d7ca6[_0x352cee(0x170)]),_0x5c806a=new persian_date_1[(_0x352cee(0x1b7))](_0x1d7ca6['registerDate'])[_0x352cee(0x1ac)](_0x352cee(0x17d))[_0x352cee(0x1be)]();_0x1d7ca6['address']=_0x1d7ca6[_0x352cee(0x175)]?_0x1d7ca6[_0x352cee(0x175)][_0x352cee(0x1ae)]()[_0x352cee(0x1b9)]>0x0?_0x1d7ca6['address'][_0x352cee(0x1ae)]():_0x352cee(0x1ba):_0x352cee(0x1ba);const _0x4f956b=!_0x1d7ca6[_0x352cee(0x171)]?_0x352cee(0x1ba):new persian_date_1['default'](_0x1d7ca6[_0x352cee(0x171)][_0x352cee(0x18d)]()+'-'+(_0x1d7ca6[_0x352cee(0x171)][_0x352cee(0x183)]()+0x1)+'-'+_0x1d7ca6[_0x352cee(0x171)][_0x352cee(0x1bc)]())[_0x352cee(0x1ac)]('jalali')[_0x352cee(0x1be)]();_0x2f8b2a>0x0&&_0x12969a['push'](Object[_0x352cee(0x18a)](Object['assign']({},_0x1d7ca6[_0x352cee(0x1bf)]()),{'countDevices':_0x2f8b2a,'jalaliRegisterDate':_0x5c806a,'userJalaliBirthday':_0x4f956b}));}return _0x12969a;});}static[_0x4cd8d6(0x1b4)](_0x525374){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x206908=_0xf637;yield users_model_1[_0x206908(0x1b7)][_0x206908(0x1c6)]({'_id':_0x525374});});}static['getCountAllAdmins'](){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x5aab69=_0xf637,_0x58c903=(yield users_model_1[_0x5aab69(0x1b7)][_0x5aab69(0x17b)]({'role':'admin'}))||0x0,_0x320923=(yield users_model_1[_0x5aab69(0x1b7)]['countDocuments']({'role':_0x5aab69(0x16b)}))||0x0,_0x44cc7b=(yield users_model_1[_0x5aab69(0x1b7)][_0x5aab69(0x17b)]({'role':_0x5aab69(0x197)}))||0x0;return _0x58c903+_0x320923+_0x44cc7b;});}static['getCountAllClients'](){return __awaiter(this,void 0x0,void 0x0,function*(){const _0xc8c3e8=_0xf637,_0x2f3e2e=yield users_model_1[_0xc8c3e8(0x1b7)][_0xc8c3e8(0x174)]({'fullName':{'$ne':null}},{'fullName':0x1,'phoneNumber':0x1,'_id':0x1,'registerDate':0x1,'address':0x1,'birthday':0x1,'role':0x1}),_0x5db783=[];for(const _0x4ce073 of _0x2f3e2e){const _0x2cfc9=yield device_entity_1[_0xc8c3e8(0x1b7)][_0xc8c3e8(0x1c5)](_0x4ce073[_0xc8c3e8(0x170)]);if(_0x4ce073[_0xc8c3e8(0x1a7)]!=_0xc8c3e8(0x17c)){if(_0x2cfc9==0x0)continue;}_0x5db783[_0xc8c3e8(0x192)](_0x4ce073);}return _0x5db783['length'];});}static['addAdmin'](_0x554539,_0x253063,_0x46b7bc,_0x4a20dd){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x3d0109=_0xf637;return yield users_model_1[_0x3d0109(0x1b7)][_0x3d0109(0x177)]([{'fullName':_0x554539,'phoneNumber':_0x253063,'role':_0x46b7bc,'enable':_0x4a20dd==_0x3d0109(0x1a5)}]);});}static[_0x4cd8d6(0x194)](_0x1a45a7,_0x4d1a0c){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x2a017f=_0xf637;return(yield users_model_1['default'][_0x2a017f(0x17b)]({'phoneNumber':_0x4d1a0c,'_id':{'$ne':_0x1a45a7}}))>0x0;});}static[_0x4cd8d6(0x187)](_0x80520c){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x20d31e=_0xf637;return(yield users_model_1[_0x20d31e(0x1b7)][_0x20d31e(0x17b)]({'phoneNumber':_0x80520c}))>0x0;});}static[_0x4cd8d6(0x189)](_0x152698,_0x4d84c6){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x62835d=_0xf637,_0x11349a=yield users_model_1[_0x62835d(0x1b7)][_0x62835d(0x174)]({'$or':[{'role':_0x62835d(0x17f)},{'role':_0x62835d(0x16b)},{'role':_0x62835d(0x197)}]},{'fullName':0x1,'phoneNumber':0x1,'_id':0x1,'registerDate':0x1,'role':0x1,'enable':0x1})[_0x62835d(0x1af)]({'registerDate':-0x1})[_0x62835d(0x1ab)](_0x4d84c6*(_0x152698-0x1))[_0x62835d(0x173)](_0x4d84c6),_0x2f3ea7=[];for(const _0x4893d0 of _0x11349a){const _0x29880a=new persian_date_1[(_0x62835d(0x1b7))](_0x4893d0[_0x62835d(0x18b)])[_0x62835d(0x1ac)]('jalali')[_0x62835d(0x1be)](),_0x8939ad=yield logs_entity_1[_0x62835d(0x1b7)][_0x62835d(0x181)](_0x4893d0[_0x62835d(0x170)]),_0xe5fa88=_0x8939ad[_0x62835d(0x190)](_0x125eb6=>{const _0x27294d=_0x62835d,_0x4d964e=new persian_date_1[(_0x27294d(0x1b7))](_0x125eb6[_0x27294d(0x1a2)][_0x27294d(0x18d)]()+'-'+(_0x125eb6[_0x27294d(0x1a2)][_0x27294d(0x183)]()+0x1)+'-'+_0x125eb6[_0x27294d(0x1a2)][_0x27294d(0x1bc)]()+'\x20'+_0x125eb6[_0x27294d(0x1a2)][_0x27294d(0x193)]()+':'+_0x125eb6[_0x27294d(0x1a2)]['getMinutes']())[_0x27294d(0x1ac)](_0x27294d(0x17d));return{'message':_0x125eb6[_0x27294d(0x16e)],'date':_0x4d964e[_0x27294d(0x1be)](_0x27294d(0x16a))};});_0x2f3ea7[_0x62835d(0x192)]({'fullName':_0x4893d0[_0x62835d(0x1bd)],'phoneNumber':_0x4893d0['phoneNumber'],'registerDate':_0x29880a,'access':_0x4893d0[_0x62835d(0x1a7)],'accessTranslate':(0x0,convert_1[_0x62835d(0x199)])(_0x4893d0[_0x62835d(0x1a7)]),'enable':_0x4893d0[_0x62835d(0x1a5)],'enableTranslate':_0x4893d0['enable']?_0x62835d(0x1b3):_0x62835d(0x1a8),'id':_0x4893d0[_0x62835d(0x170)],'logs':JSON[_0x62835d(0x19d)](_0xe5fa88)});}return _0x2f3ea7;});}static[_0x4cd8d6(0x1c3)](_0x27f7b9,_0x4b6ddd){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x34a98a=_0xf637,_0x3ce643=yield users_model_1[_0x34a98a(0x1b7)][_0x34a98a(0x174)]({'fullName':{'$ne':null}},{'fullName':0x1,'phoneNumber':0x1,'_id':0x1,'registerDate':0x1,'address':0x1,'birthday':0x1,'role':0x1})[_0x34a98a(0x1af)]({'registerDate':-0x1})[_0x34a98a(0x1ab)](_0x4b6ddd*(_0x27f7b9-0x1))[_0x34a98a(0x173)](_0x4b6ddd),_0x4d881b=[];for(const _0x6dcbbb of _0x3ce643){const _0x123a55=yield device_entity_1[_0x34a98a(0x1b7)]['getAllDevicesCount'](_0x6dcbbb[_0x34a98a(0x170)]);if(_0x6dcbbb[_0x34a98a(0x1a7)]!=_0x34a98a(0x17c)){if(_0x123a55==0x0)continue;}const _0x595ec3=new persian_date_1['default'](_0x6dcbbb[_0x34a98a(0x18b)])['calendar'](_0x34a98a(0x17d))[_0x34a98a(0x1be)]();_0x6dcbbb['address']=_0x6dcbbb[_0x34a98a(0x175)]?_0x6dcbbb[_0x34a98a(0x175)]['trim']()['length']>0x0?_0x6dcbbb[_0x34a98a(0x175)]['trim']():_0x34a98a(0x1ba):'ندارد';const _0x4aed1d=!_0x6dcbbb['birthday']?_0x34a98a(0x1ba):new persian_date_1[(_0x34a98a(0x1b7))](_0x6dcbbb[_0x34a98a(0x171)][_0x34a98a(0x18d)]()+'-'+(_0x6dcbbb[_0x34a98a(0x171)][_0x34a98a(0x183)]()+0x1)+'-'+_0x6dcbbb[_0x34a98a(0x171)][_0x34a98a(0x1bc)]())[_0x34a98a(0x1ac)](_0x34a98a(0x17d))[_0x34a98a(0x1be)]();_0x4d881b[_0x34a98a(0x192)](Object['assign'](Object['assign']({},_0x6dcbbb[_0x34a98a(0x1bf)]()),{'countDevices':_0x123a55,'jalaliRegisterDate':_0x595ec3,'userJalaliBirthday':_0x4aed1d}));}return _0x4d881b;});}static[_0x4cd8d6(0x185)](_0x1ea5ec,_0x425b75,_0x35a84e,_0x42ffdd,_0x37d35f){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x2571ae=_0xf637;yield users_model_1[_0x2571ae(0x1b7)][_0x2571ae(0x1c1)]({'_id':_0x1ea5ec},{'$set':{'fullName':_0x425b75,'phoneNumber':_0x35a84e,'role':_0x42ffdd,'enable':_0x37d35f==_0x2571ae(0x1a5)}});});}static[_0x4cd8d6(0x188)](_0x57054b,_0x21aa9a,_0xfb65b3){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x35ab13=_0xf637;yield users_model_1[_0x35ab13(0x1b7)][_0x35ab13(0x1c1)]({'_id':_0x57054b},{'$set':{'fullName':_0x21aa9a,'phoneNumber':_0xfb65b3}});});}static[_0x4cd8d6(0x191)](_0xc8d337){return __awaiter(this,void 0x0,void 0x0,function*(){const _0x4e4b12=_0xf637;yield users_model_1[_0x4e4b12(0x1b7)][_0x4e4b12(0x1c6)]({'_id':_0xc8d337});});}}exports[_0x4cd8d6(0x1b7)]=UserEntity;