import express, { Request, Response } from 'express';
import {deleteCustomer, editUser} from "../controller/customer.controller";
import {clientPage} from "../page_view/clients.pageview";
const router = express.Router();


router.post('/delete',deleteCustomer)
router.post('/edit',editUser)
router.get('/',clientPage)

export { router as customerRoute };
