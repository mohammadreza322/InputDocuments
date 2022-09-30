import {Request, Response} from "express";
import UserEntity from "../entities/user.entity";
import AhpValidator from "../classes/validator";
import {Pagination} from "../classes/pagination";

export const adminPage = async(req:Request,res:Response) => {
    const countAllAdmins = await UserEntity.getCountAllAdmins()

    const limit = 10;
    let pageNumber = req.query.page
    if (!pageNumber) {
        pageNumber = "1"
    }

    if (!AhpValidator.isNumber(pageNumber.toString())) {
        pageNumber = "1"
    }

    const page = parseInt(pageNumber.toString())

    const allAdmins = await UserEntity.getAllAdmins(page,limit)

    const pagination = new Pagination(page,limit,countAllAdmins,allAdmins.length)

    res.locals.scripts.push('/js/admin.js')
    return res.render('dashboard/main.ejs',{
        title:'مدیریت مدیرها',
        page:'admin',
        countAllAdmins,
        allAdmins,
        pageNumber:page,
        limit,
        pagination
    })
}