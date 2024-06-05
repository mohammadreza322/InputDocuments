import express, {NextFunction, Request, Response, urlencoded} from 'express';
import { json } from 'body-parser';
import { apiRouter } from './routes/api.router';
import connectDb from './config/db';
import './types/global.type';
import AhpMqtt from './classes/mqtt';
import cors from 'cors'
import helmet from 'helmet';
import * as connectMongoDBSession from 'connect-mongodb-session';
import {mongoConnection, sessionName, sessionSecret} from "./utility/constants";
import session from 'express-session';
import * as path from "path";
import csurf from "csurf";
import {dashboardRoute} from "./routes/dashboard.route";
import './types/session'

process.env.TZ = 'Asia/Tehran';

const app = express();

// app.use(cors())
app.use(json());
//app.use(helmet({contentSecurityPolicy: false,}));



const MongoDBStore = connectMongoDBSession.default(session);
const sessionStore  = MongoDBStore({
	uri: mongoConnection,
	collection: 'sessions',
	expires: 1000 * 60 * 60 * 24*3
})

app.use(
	session({
		name: sessionName,
		resave: true,
		saveUninitialized: true,
		secret: sessionSecret,
		rolling: true,
		store: sessionStore,
		cookie: {
			maxAge: 28800000,
		},
	}),
);

app.use((req:Request,res:Response,next:NextFunction) => {
	// const responseSettings = {
	// 	"AccessControlAllowOrigin": req.headers.origin,
	// 	"AccessControlAllowHeaders": "Content-Type,X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5,  Date, X-Api-Version, X-File-Name",
	// 	"AccessControlAllowMethods": "POST, GET, PUT, DELETE, OPTIONS",
	// 	"AccessControlAllowCredentials": 'true'
	// };
	// res.setHeader('Access-Control-Allow-Origin', '*');
	// res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE'); // If needed
	// res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type,x-auth-token'); // If needed
	// res.setHeader('Access-Control-Allow-Credentials', "true")
	// res.header("Access-Control-Allow-Credentials", responseSettings.AccessControlAllowCredentials);
	// res.header("Access-Control-Allow-Origin",  responseSettings.AccessControlAllowOrigin);
	// res.header("Access-Control-Allow-Headers", (req.headers['access-control-request-headers']) ? req.headers['access-control-request-headers'] : "x-requested-with");
	// res.header("Access-Control-Allow-Methods", (req.headers['access-control-request-method']) ? req.headers['access-control-request-method'] : responseSettings.AccessControlAllowMethods);
	// console.log(req.session)
	return next()
})


app.use('/api', apiRouter);

//dashboard configs


//server static files
app.use('/public',express.static(path.join(__dirname , '/public')));

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname,'views'));
app.set('view options', { delimiter: '?' });

app.use(urlencoded({ extended: true }));

//csurf configs
app.use(csurf());

app.use(function (err: any, req: Request, res: Response, next: NextFunction) {
	console.log("its a error catrch it");
	console.log(err);

	if (err.code !== 'EBADCSRFTOKEN') return next(err);

	// handle CSRF token errors here
	return res.status(403).json({ text: 'error',status:false });
});

//locals values for every page
app.use(async (req:Request, res:Response, next:NextFunction) => {
	try {
		res.locals.isAuthenticated = req.session.isUserLoggedIn;
		res.locals.csrfToken = req.csrfToken();
		res.locals.styles = [];
		res.locals.scripts = [];
		res.locals.hostname = req.hostname;
		res.locals.queries = req.query
		next();
	} catch (e) {
		console.error('error in locals');
		console.dir(e);
		return res.json({status:false,text:'خطایی پیش آمده'})

	}
});

//define site routes

// app.use((req:CustomRequest,res:Response,next:NextFunction) => {
// 	console.log(req.body)
// 	return next;
// 	for (const key in req.body) {
// 		if(key == 'blogText') {
// 			continue;
// 		}
//
// 		// if(req.body[key]) {
// 		// 	req.body[key] = escape_html(req.body[key])
// 		// }
// 	}
//
// 	for (const key in req.query) {
// 		if( req.query[key]){
// 			req.query[key] = escape_html(req.query[key]!.toString())
// 		}
//
// 		res.locals.queries = req.query
// 	}
//
// 	for (const key in req.params) {
// 		req.params[key] = escape_html(req.params[key])
// 	}
//
// 	return next()
// })

//authentication route
app.use('/dashboard', dashboardRoute);
//dashboard routes
// app.use('/dashboard', dashboardRoute);

app.use('/error/404',(req:Request,res:Response) => {
	return res.render('error/404.ejs')
})
app.use('/error/403',(req:Request,res:Response) => {
	return res.render('error/403.ejs')
})

// app.use('/', (_: Request, res: Response) => {
// 	return res.redirect('/dashboard/auth');
// });

const PORT = process.env.PORT || 8800;

connectDb().then(() => {
	console.log('mongo database connected');
	AhpMqtt.getInstance().connect();
	app.listen(PORT, () => console.log(`server start at ${PORT}`));
});
