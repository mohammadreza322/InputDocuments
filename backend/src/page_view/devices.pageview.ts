import {Request, Response} from "express";
import DeviceEntity from "../entities/device.entity";
import AhpValidator from "../classes/validator";
import {Pagination} from "../classes/pagination";

export const devicesPage = async (req:Request,res:Response) => {

    let {activeTab,coolerPage,powerPage} = req.query;



    if(!activeTab) {
        activeTab = 'cooler'
    }

    activeTab = activeTab.toString();

    if(!['cooler','power'].includes(activeTab)) {
        activeTab = 'cooler'
    }

    req.query.activeTab = activeTab;

    if (!coolerPage) {
        coolerPage = "1"
    }

    if (!AhpValidator.isNumber(coolerPage.toString())) {
        coolerPage = "1"
    }

    let coolerPageNumber = parseInt(coolerPage.toString())

    if(coolerPageNumber < 1) {
        coolerPageNumber =1
    }

    if (!powerPage) {
        powerPage = "1"
    }

    if (!AhpValidator.isNumber(powerPage.toString())) {
        powerPage = "1"
    }

    let powerPageNumber = parseInt(powerPage.toString())

    if(powerPageNumber<1) {
        powerPageNumber = 1
    }

    const limit = 10;

    const countAllPowers =await  DeviceEntity.getCountAllPowersOutStore()
    const countAllCoolers = await DeviceEntity.getCountAllCoolersOutStore()

    const allPowers = await DeviceEntity.getAllPowers(powerPageNumber,limit)

    const powerPagination = new Pagination(powerPageNumber,limit,countAllPowers,allPowers.length,"powerPage")

    const allCoolers = await DeviceEntity.getAllCoolers(coolerPageNumber,limit)
    const coolerPagination = new Pagination(coolerPageNumber,limit,countAllCoolers,allCoolers.length,"coolerPage")

    res.locals.queries = req.query

    res.locals.scripts.push('/js/device.js')

    return res.render('dashboard/main.ejs',{
        title:'مدیریت دستگاه ها',
        page:'devices',
        countAllPowers,
        countAllCoolers,
        allPowers,
        powerPagination,
        activeTab,
        powerPageNumber,
        limit,
        allCoolers,
        coolerPagination,
        coolerPageNumber
    })
}

export const storeHouse = async (req:Request,res:Response) => {


    let {activeTab,coolerPage,powerPage} = req.query;



    if(!activeTab) {
        activeTab = 'cooler'
    }

    activeTab = activeTab.toString();

    if(!['cooler','power'].includes(activeTab)) {
        activeTab = 'cooler'
    }

    req.query.activeTab = activeTab;

    if (!coolerPage) {
        coolerPage = "1"
    }

    if (!AhpValidator.isNumber(coolerPage.toString())) {
        coolerPage = "1"
    }


    let coolerPageNumber = parseInt(coolerPage.toString())

    if(coolerPageNumber < 1) {
        coolerPageNumber = 1
    }

    if (!powerPage) {
        powerPage = "1"
    }

    if (!AhpValidator.isNumber(powerPage.toString())) {
        powerPage = "1"
    }

    let powerPageNumber = parseInt(powerPage.toString())

    if(powerPageNumber < 1) {
        powerPageNumber = 1
    }

    const limit = 10;

    const countAllPowers = await DeviceEntity.getCountAllPowersInStore()
    const countAllCoolers = await DeviceEntity.getCountAllCoolersInStore()

    const allPowers = await DeviceEntity.getAllPowersInStore(powerPageNumber,limit)

    const powerPagination = new Pagination(powerPageNumber,limit,countAllPowers,allPowers.length,"powerPage")

    const allCoolers = await DeviceEntity.getAllCoolersInStore(coolerPageNumber,limit)
    const coolerPagination = new Pagination(coolerPageNumber,limit,countAllCoolers,allCoolers.length,"coolerPage")

    res.locals.queries = req.query
    res.locals.scripts.push('/js/storehouse.js')

    res.render('dashboard/main.ejs',{
        title:'انبار',
        page:'storehouse',
        countAllPowers,
        countAllCoolers,
        allPowers,
        allCoolers,
        powerPagination,
        coolerPagination,
        activeTab,
        powerPageNumber,
        coolerPageNumber,
        limit
    })
}