import {Request, Response} from "express";
import UserEntity from "../entities/user.entity";
import AhpValidator from "../classes/validator";
import {Pagination} from "../classes/pagination";

export const clientPage = async (req:Request,res:Response) => {

    const limit = 10;
    let pageNumber = req.query.page
    if (!pageNumber) {
        pageNumber = "1"
    }

    if (!AhpValidator.isNumber(pageNumber.toString())) {
        pageNumber = "1"
    }

    const page = parseInt(pageNumber.toString())

    const allClientsCounts = await UserEntity.getCountAllClients()

    const allClients = await UserEntity.getAllClients(page,limit)

    const pagination = new Pagination(page,limit,allClientsCounts,allClients.length)

    res.locals.scripts.push('/js/lib/persian-date.js','/js/lib//persian-datepicker.js','/js/client.js')
    res.locals.styles.push('/css/lib/persian-datepicker.css')

    return res.render('dashboard/main.ejs',{
        title:'مدریت کاربران',
        page:'client',
        allClientsCounts,
        allClients,
        pageNumber:page,
        limit,
        pagination
    })
}