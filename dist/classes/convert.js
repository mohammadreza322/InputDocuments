"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.numToPrice = exports.adminRoleTranslate = exports.convertDateToTimeStamp = exports.escape_html = void 0;
const entityMap = new Map(Object.entries({
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "--": '&#8211;'
}));
function escape_html(source) {
    const output = String(source).replace(/--/, (s) => entityMap.get(s));
    return output.replace(/[&<>]/g, (s) => entityMap.get(s));
}
exports.escape_html = escape_html;
function convertDateToTimeStamp(date) {
    // console.log(date.getTime())
    return Math.floor(date.getTime() / 1000);
}
exports.convertDateToTimeStamp = convertDateToTimeStamp;
function adminRoleTranslate(role) {
    const translates = {
        'admin': 'مدیر داشبورد',
        'warehouse': 'انبار دار',
        'customer_service': 'امور مشتریان'
    };
    return translates[role];
}
exports.adminRoleTranslate = adminRoleTranslate;
function numToPrice(number) {
}
exports.numToPrice = numToPrice;
