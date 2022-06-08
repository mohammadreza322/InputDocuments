import express,{Request,Response} from 'express'
import { getMobile } from '../controller/login';

const router = express.Router();

router.post('/get-mobile',getMobile)

export {router as loginRouter}
