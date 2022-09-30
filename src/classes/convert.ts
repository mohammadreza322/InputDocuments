const entityMap = new Map<string, string>(Object.entries({
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "--":'&#8211;'
}))

export function escape_html(source: string) {
    const output = String(source).replace(/--/,(s: string) => entityMap.get(s)!)
    return output.replace(/[&<>]/g, (s: string) => entityMap.get(s)!);
}

export function convertDateToTimeStamp(date:Date) {
    // console.log(date.getTime())
    return Math.floor(date.getTime()/1000)
}

export function adminRoleTranslate(role:string) {
    const translates = {
        'admin':'مدیر داشبورد',
        'warehouse':'انبار دار',
        'customer_service':'امور مشتریان'
    }

    return translates[role]
}

export function numToPrice(number) {

}