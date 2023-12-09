import express, { Request, Response } from 'express';
import {deleteCustomer, editUser} from "../controller/customer.controller";
import {adminPage} from "../page_view/admin.pageview";
import {addAdmin, deleteAdmin, editAdmin, editCurrentAdmin} from "../controller/user.controller";
import {devicesPage, storeHouse} from "../page_view/devices.pageview";
import {deleteOwnerOfDevice, kickDevice} from "../controller/device.controller";
const router = express.Router();


router.post('/delete',deleteOwnerOfDevice)
router.post('/kick',kickDevice)
router.get('/',devicesPage)
// router.post('/edit',editAdmin)
// router.post('/delete',deleteAdmin)
// router.post('/current',editCurrentAdmin)


export { router as deviceSiteRouter };
