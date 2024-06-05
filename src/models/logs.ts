import {Schema,model,Document,Model,Types} from "mongoose";


export interface ILog extends Document{
    date:Date;
    _id:Types.ObjectId;
    message:string;
    logId:Types.ObjectId
}

const logSchema = new Schema({
    date:{
        type:Date,
        default:Date.now
    },
    message:{
        type:String,
    },
    logId:{
        type: Types.ObjectId,
    }
})

const Logs: Model<ILog> = model<ILog>('Logs',logSchema);
export default Logs