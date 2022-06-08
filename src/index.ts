import express from 'express';
import {json} from 'body-parser';
import { apiRouter } from './routes/api';
import mongoose from 'mongoose'; 

const app = express()

app.use(json())

app.use(apiRouter)

//mongoose.connect()

app.listen(3000,() => console.log('server start at 3000'));