'use strict';const _0xff8eba=_0x2288;function _0x2288(_0x52377c,_0x1ff9bf){const _0x24cc47=_0x24cc();return _0x2288=function(_0x2288dc,_0x36af68){_0x2288dc=_0x2288dc-0x72;let _0xc187e3=_0x24cc47[_0x2288dc];return _0xc187e3;},_0x2288(_0x52377c,_0x1ff9bf);}(function(_0x2ae11b,_0x5ea7f1){const _0x57cac7=_0x2288,_0xe0b32e=_0x2ae11b();while(!![]){try{const _0x13884e=parseInt(_0x57cac7(0x7f))/0x1*(parseInt(_0x57cac7(0x84))/0x2)+-parseInt(_0x57cac7(0x7d))/0x3+-parseInt(_0x57cac7(0x79))/0x4+-parseInt(_0x57cac7(0x74))/0x5*(-parseInt(_0x57cac7(0x76))/0x6)+-parseInt(_0x57cac7(0x77))/0x7*(parseInt(_0x57cac7(0x88))/0x8)+-parseInt(_0x57cac7(0x78))/0x9*(-parseInt(_0x57cac7(0x89))/0xa)+-parseInt(_0x57cac7(0x80))/0xb*(-parseInt(_0x57cac7(0x87))/0xc);if(_0x13884e===_0x5ea7f1)break;else _0xe0b32e['push'](_0xe0b32e['shift']());}catch(_0x3aa829){_0xe0b32e['push'](_0xe0b32e['shift']());}}}(_0x24cc,0x37816));function _0x24cc(){const _0x4274fa=['14311DJbnAF','defineProperty','ObjectId','model','21274pgXpDG','Cooler','mongoose','2028knPDMd','8XSQiXL','110EqirFr','assign','brand0','Schema','power','658945ohjjMW','PowerStrip','12iXDKRO','287931TRhcnC','181881iEVuse','884056mdWIdV','now','usb','Auto','1127412rCLVDR','string','15rwrKKH'];_0x24cc=function(){return _0x4274fa;};return _0x24cc();}Object[_0xff8eba(0x81)](exports,'__esModule',{'value':!![]}),exports['Cooler']=exports['PowerStrip']=void 0x0;const mongoose_1=require(_0xff8eba(0x86)),scheduleDeviceDefaultSchema={'name':{'type':'string'},'start':{'type':_0xff8eba(0x7e)},'end':{'type':'string'},'enable':{'type':'boolean','default':!![]},'repeat':{'default':[],'type':[{'type':String}]}},defaultDeviceSchema={'serialNumber':{'type':_0xff8eba(0x7e),'required':!![]},'name':{'type':'string'},'category':{'type':_0xff8eba(0x7e)},'createAt':{'type':Date,'default':Date[_0xff8eba(0x7a)]},'registerAt':{'type':Date},'owner':{'type':mongoose_1['Types'][_0xff8eba(0x82)]},'deviceLastConnection':{'type':_0xff8eba(0x7e)},'password':{'type':_0xff8eba(0x7e)},'insertedUser':{'type':mongoose_1['Types'][_0xff8eba(0x82)]}},powerStripSchema=new mongoose_1[(_0xff8eba(0x72))](Object[_0xff8eba(0x8a)](Object['assign']({},defaultDeviceSchema),{'connectors':{'type':[{'status':Boolean,'name':String,'connectorType':{'type':String,'enum':[_0xff8eba(0x7b),_0xff8eba(0x73)]},'connectorId':Number}],'default':[]},'totalVoltage':{'type':Number,'default':0x0},'schedule':{'type':[{'port':Number,'name':String,'start':String,'end':String,'enable':{'type':Boolean,'default':!![]},'repeat':{'type':[{'type':String}],'default':[]}}],'default':[]}}));exports[_0xff8eba(0x75)]=(0x0,mongoose_1['model'])(_0xff8eba(0x75),powerStripSchema);const coolerSchema=new mongoose_1['Schema'](Object[_0xff8eba(0x8a)](Object[_0xff8eba(0x8a)]({},defaultDeviceSchema),{'brand':{'type':String,'default':_0xff8eba(0x8b)},'model':{'type':String},'temp':{'type':Number,'default':0x14},'mode':{'type':String,'default':_0xff8eba(0x7c)},'horizontalSwing':{'type':String,'default':_0xff8eba(0x7c)},'verticalSwing':{'type':String,'default':_0xff8eba(0x7c)},'fan':{'type':String,'default':_0xff8eba(0x7c)},'timer':{'type':String,'default':'Off'},'schedule':{'type':[scheduleDeviceDefaultSchema],'default':[]},'power':{'type':Boolean,'default':!![]}}));exports[_0xff8eba(0x85)]=(0x0,mongoose_1[_0xff8eba(0x83)])(_0xff8eba(0x85),coolerSchema);