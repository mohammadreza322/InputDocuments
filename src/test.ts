import connectDb from './config/db';
import Permission, { IPermission } from './models/permission.model';

connectDb().then(async () => {
	const permission: IPermission = new Permission({
		role: 'user',
		GET: ['/api/user/get-name'],
		POST: [],
		DELETE: [],
		PUT: [],
	});

	await permission.save();
	console.log('done');
	process.exit(0);
});
