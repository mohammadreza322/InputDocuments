import express, { Request, Response } from 'express';
import { loginRouter } from './login.router';

const router = express.Router();

router.use(loginRouter);

router.get('/', (req: Request, res: Response) => {
	return res.send('okok');
});

export { router as apiRouter };
