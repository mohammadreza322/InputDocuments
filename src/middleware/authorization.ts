import { Response, NextFunction, Request } from 'express';
// import type { CustomRequest } from '../types/global.type';
import Permission, { IPermission } from '../models/permission.model';
import isJWT from 'validator/lib/isJWT';
import Token, { IToken } from '../models/tokens.model';
import { jsonWebTokenSecretKey } from '../utility/constants';
import User, {IUser} from '../models/users.model';
import { CustomRequest } from '../types/global.type';
import UserEntity from "../entities/user.entity";
import {getUserFullInformationOutput} from "../types/user.type";

const jwt = require('jsonwebtoken');

interface jwtInput {
	id: string;
}

export const getAuthorization = async (
	req: CustomRequest,
	res: Response,
	next: NextFunction,
) => {
	const userToken = req.header('x-auth-token');

	try {
		if (!userToken) {
			return res.status(401).json({ message: 'Token is not valid!1' });
		}

		if (!isJWT(userToken)) {
			return res.status(401).json({ message: 'Token is not valid!2' });
		}

		const token: IToken | null = await Token.findOne({ token: userToken });

		if (!token) {
			return res.status(401).json({ message: 'Token is not valid3' });
		}

		const decoded = jwt.verify(userToken, jsonWebTokenSecretKey);

		const user = await User.findById(decoded.id);

		if (!user) {
			return res.status(403).json({ message: 'Token is not valid!6' });
		}

		req.userDetails = user;
		req.userId = user._id!;

		return next();
	} catch (err) {
		console.error('authorization error');
		console.error(err);
		return res.status(401).json({ message: 'Token is not valid!7' });
	}
};

export const hasPermission = async (
	req: CustomRequest,
	res: Response,
	next: NextFunction,
) => {
	try {
		const { userDetails } = req;
		if (!userDetails) {
			return res.status(404).json({ message: 'permission denied' });
		}

		let path: string | null = null;

		if (req.path.charAt(0) === '/') {
			path = req.baseUrl + req.path;
		} else {
			path = `${req.baseUrl}/${req.path}`;
		}

		const method: string = req.method;
		if (path[path.length - 1] === '/') {
			path = path.substring(0, path.length - 1);
		}

		const permissions: IPermission | null = await Permission.findOne({
			role: userDetails.role,
		});

		const hasPermission = permissions
			?.get(method.toUpperCase())
			.find((permission: string) => {
				const permissionRegex = new RegExp(permission);
				return permissionRegex.test(path!);
			});

		if (!hasPermission) {
			return res.status(404).json({ message: 'permission denied' });
		}

		return next();
	} catch (e) {
		console.error('inside permission middle  ware');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده!' });
	}
};

export const hasPermissionDashboard = async (req:Request,res:Response,next:NextFunction) => {
	try {
		if (!req.session.isUserLoggedIn) {
			// console.log("in permission user not login")
			// console.log(req.session.isUserLoggedIn)
			return res.redirect('/dashboard/auth')
		}

		const sessionUserPhoneNumber: string = req.session.userPhone!;

		const user:getUserFullInformationOutput = await UserEntity.getUserInformationWithPhoneNumber(sessionUserPhoneNumber);

		if (!user) {
			req.session.isUserLoggedIn = false;
			return res.redirect('/dashboard/auth')
		}

		if (user.role =='user') {
			return res.redirect('/error/403')
		}

		let path: string | null = null;

		if (req.path.charAt(0) === '/') {
			path = req.baseUrl + req.path;
		} else {
			path = `${req.baseUrl}/${req.path}`;
		}

		const method: string = req.method;
		if (path[path.length - 1] === '/') {
			path = path.substring(0, path.length - 1);
		}

		const permissions: IPermission | null = await Permission.findOne({
			role: user.role,
		},);

		if(!permissions){
			return res.redirect('/dashboard/auth')
		}


		const hasPermission = permissions
			.get(method.toUpperCase())
			.find((permission: string) => {
				const permissionRegex = new RegExp(permission);
				return permissionRegex.test(path!);
			});

		// console.log(path)

		if (!hasPermission) {
			if(method.toUpperCase() == 'GET') {
				res.redirect(permissions.initialRoute)
			}
			return res.json({status:false,message:'دسترسی غیر مجاز'});
		}

		req.user = user;

		res.locals.userName = user.fullName.split(' ')[0];
		res.locals.fullName = user.fullName;
		res.locals.phoneNumber = user.phoneNumber
		res.locals.role = user.role

		const routes = [
			{
				route:'/dashboard',
				title:'پیشخوان',
				image:'element-4.svg',
				name:'dashboard'
			},
			{
				route:'/dashboard/admin',
				title:'مدیران',
				image:'user.svg',
				name:'admin'
			},
			{
				route:'/dashboard/client',
				title:'مشتریان',
				image:'profile-2user.svg',
				name:'client'
			},
			{
				route:'/dashboard/devices',
				title:'دستگاه‌ها',
				image:'cpu.svg',
				name:'devices'
			},
			{
				route:'/dashboard/store_room',
				title:'انبار',
				image:'3d-cube-scan.svg',
				name:'storehouse'
			}
		]

		res.locals.routes = routes.filter((r) => permissions
			?.get(method.toUpperCase())
			.includes(r.route))
		return next();
	} catch (e) {
		console.error('inside site permission middle  ware');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده!' });
	}
}
