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
	//return next();
	const userToken = req.header('x-auth-token');

	try {
		if (!userToken) {
			return res.json({ message: 'Token is not valid!1' ,refreshToken1:true});
		}

		if (!isJWT(userToken)) {
			return res.json({ message: 'Token is not valid!2',refreshToken1:true });
		}

		const token: IToken | null = await Token.findOne({ token: userToken });

		if (!token) {
			return res.json({ message: 'Token is not valid3',refreshToken1:true });
		}

		const decoded = jwt.decode(userToken, jsonWebTokenSecretKey);

		const user = await User.findById(decoded.id);

		if (!user) {
			return res.json({ message: 'Token is not valid!6',refreshToken1:true });
		}

		req.userDetails = user;
		req.userId = user._id!;

		return next();
	} catch (err) {
		console.error('authorization error');
		console.error(err);
		return res.json({ message: 'Token is not valid!7',refreshToken1:true });
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

		console.log("***********")
		console.log(path)
		console.log(method)

		return next();

		const hasPermission = permissions
			?.get(method.toUpperCase())
			.find((permission: string) => {
				const permissionRegex = new RegExp(permission);
				return permissionRegex.test(path!);
			});

		console.log(hasPermission)


		console.log({
			hasPermission,
			path,
			method
		})

		if (!hasPermission) {
			console.log("fuuuuuuuuuuuuuuuuuuck")
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
			return res.redirect('/auth')
		}

		const sessionUserPhoneNumber: string = req.session.userPhone!;

		const user:getUserFullInformationOutput = await UserEntity.getUserInformationWithPhoneNumber(sessionUserPhoneNumber);

		if (!user) {
			req.session.isUserLoggedIn = false;
			return res.redirect('/auth')
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
			return res.redirect('/auth')
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
				route:'/',
				title:'پیشخوان',
				image:'element-4.svg',
				name:'dashboard'
			},
			{
				route:'/admin',
				title:'مدیران',
				image:'user.svg',
				name:'admin'
			},
			{
				route:'/client',
				title:'مشتریان',
				image:'profile-2user.svg',
				name:'client'
			},
			{
				route:'/devices',
				title:'دستگاه‌ها',
				image:'cpu.svg',
				name:'devices'
			},
			{
				route:'/store_room',
				title:'انبار',
				image:'3d-cube-scan.svg',
				name:'storehouse'
			}
		]

		console.log('###############################')
		res.locals.routes = routes.filter((r) => {
			const p = r.route == '/' ? '/dashboard' : `/dashboard${r.route}`;

			return permissions
				?.get(method.toUpperCase())
				.includes(p)
		})

		console.log(res.locals.routes)
		return next();
	} catch (e) {
		console.error('inside site permission middle  ware');
		console.error(e);
		return res.status(500).json({ message: 'خطایی پیش آمده!' });
	}
}
