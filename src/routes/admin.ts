import express, { Request, Response } from 'express';
import {deleteCustomer, editUser} from "../controller/customer.controller";
import {adminPage} from "../page_view/admin.pageview";
import {addAdmin, deleteAdmin, editAdmin, editCurrentAdmin} from "../controller/user.controller";
const router = express.Router();


router.get('/',adminPage)
router.post('/add',addAdmin)
router.post('/edit',editAdmin)
router.post('/delete',deleteAdmin)
router.post('/current',editCurrentAdmin)


export { router as adminRoute };
