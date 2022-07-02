import express, { Request, Response } from 'express';
import { deviceRouter } from './device.route';
import { loginRouter } from './login.router';
import { userRouter } from './user.router';

const router = express.Router();

router.use(loginRouter);

router.use('/user', userRouter);
router.use('/device', deviceRouter);

router.get('/', (req: Request, res: Response) => {
	return res.send('server is run');
});

router.use((req: Request, res: Response) => {
	return res.status(404).send('are you lost baby?');
});

export { router as apiRouter };
