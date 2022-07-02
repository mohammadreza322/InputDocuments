import express from 'express';
import { json } from 'body-parser';
import { apiRouter } from './routes/api.router';
import connectDb from './config/db';
import './types/global.type';
import AhpMqtt from './classes/mqtt';

process.env.TZ = 'Asia/Tehran';

const app = express();

app.use(json());

app.use('/api', apiRouter);

const PORT = process.env.PORT || 8800;

connectDb().then(() => {
	console.log('mongo database connected');
	AhpMqtt.getInstance().connect();
	app.listen(PORT, () => console.log(`server start at ${PORT}`));
});
