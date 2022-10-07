import { Types } from "mongoose"
import BrokerProvider from "./classes/broker_provider"
import connectDb from "./config/db"
import DeviceEntity from "./entities/device.entity"
import { PowerStrip } from "./models/device.model"
import Permission from "./models/permission.model"

connectDb().then(async ()=> {
	console.log(await BrokerProvider.userExist('06dc732cc261b06a640268926fe290d55f0928ea') )
	
	console.log("done")
	process.exit(0)
})