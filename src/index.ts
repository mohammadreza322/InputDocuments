import express from 'express';
import {json} from 'body-parser';
import { apiRouter } from './routes/api';
import mongoose,{ConnectOptions} from 'mongoose'; 
import {mongoConnection} from './utility/constants'

const app = express()

app.use(json())

app.use('/api',apiRouter)

mongoose.connect(mongoConnection).then(() => {
  console.log("mongo database connected")
  app.listen(3000,() => console.log('server start at 3000'));
})

