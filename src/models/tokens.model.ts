import {model,Schema,Model,Types} from 'mongoose'


const tokenSchema = new Schema({
    token: {
        type:String,
        required: true,
    },
    refreshToken: {
        type:String,
        required: true,
    },
    agent: {
        type:String,
        required: true,
    },
    time: {
        type: Date,
        required: true,
        default: Date.now
    },
    user: {
        type:Types.ObjectId,
        required: true,
        ref:'User'
    }
})
const Token= model('Tokens',tokenSchema)
export default Token