import mongoose from 'mongoose';
import { mongoConnection } from '../utility/constants';

const connectDb = async () => {
	try {
		await mongoose.connect(mongoConnection);

		console.log('MongoDb Connected...');
	} catch (e) {
		console.error(e);
		process.exit(1);
	}
};

export default connectDb;
