import express, {NextFunction, Request, Response} from 'express';
import { json } from 'body-parser';
import { apiRouter } from './routes/api.router';
import connectDb from './config/db';
import './types/global.type';
import AhpMqtt from './classes/mqtt';
import cors from 'cors'

process.env.TZ = 'Asia/Tehran';

const app = express();

app.use(cors())
app.use(json());

app.use((_:Request,res:Response,next:NextFunction) => {
	res.setHeader('Access-Control-Allow-Origin', '*');
	res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE'); // If needed
	res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type,x-auth-token'); // If needed
	res.setHeader('Access-Control-Allow-Credentials', "true")
	return next()
})

app.use('/api', apiRouter);

app.use('/', (_: Request, res: Response) => {
	return res.json({ message: 'ok server' });
});

const PORT = process.env.PORT || 8800;

connectDb().then(() => {
	console.log('mongo database connected');
	AhpMqtt.getInstance().connect();
	app.listen(PORT, () => console.log(`server start at ${PORT}`));
});
