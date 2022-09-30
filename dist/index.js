"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importStar(require("express"));
const body_parser_1 = require("body-parser");
const api_router_1 = require("./routes/api.router");
const db_1 = __importDefault(require("./config/db"));
require("./types/global.type");
const mqtt_1 = __importDefault(require("./classes/mqtt"));
const cors_1 = __importDefault(require("cors"));
const connectMongoDBSession = __importStar(require("connect-mongodb-session"));
const constants_1 = require("./utility/constants");
const express_session_1 = __importDefault(require("express-session"));
const path = __importStar(require("path"));
const csurf_1 = __importDefault(require("csurf"));
const dashboard_route_1 = require("./routes/dashboard.route");
require("./types/session");
process.env.TZ = 'Asia/Tehran';
const app = (0, express_1.default)();
app.use((0, cors_1.default)());
app.use((0, body_parser_1.json)());
//app.use(helmet({contentSecurityPolicy: false,}));
app.use((_, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE'); // If needed
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type,x-auth-token'); // If needed
    res.setHeader('Access-Control-Allow-Credentials', "true");
    return next();
});
//dashboard configs
const MongoDBStore = connectMongoDBSession.default(express_session_1.default);
const sessionStore = MongoDBStore({
    uri: constants_1.mongoConnection,
    collection: 'sessions',
    expires: 1000 * 60 * 60 * 24 * 3
});
app.use((0, express_session_1.default)({
    name: constants_1.sessionName,
    resave: true,
    saveUninitialized: true,
    secret: constants_1.sessionSecret,
    rolling: true,
    store: sessionStore,
    cookie: {
        maxAge: 28800000,
    },
}));
app.use('/api', api_router_1.apiRouter);
//server static files
app.use(express_1.default.static(path.join(__dirname, '/public')));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.set('view options', { delimiter: '?' });
app.use((0, express_1.urlencoded)({ extended: true }));
//csurf configs
app.use((0, csurf_1.default)());
app.use(function (err, req, res, next) {
    console.log("its a error catrch it");
    console.log(err);
    if (err.code !== 'EBADCSRFTOKEN')
        return next(err);
    // handle CSRF token errors here
    return res.status(403).json({ text: 'error', status: false });
});
//locals values for every page
app.use((req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        res.locals.isAuthenticated = req.session.isUserLoggedIn;
        res.locals.csrfToken = req.csrfToken();
        res.locals.styles = [];
        res.locals.scripts = [];
        res.locals.hostname = req.hostname;
        res.locals.queries = req.query;
        next();
    }
    catch (e) {
        console.error('error in locals');
        console.dir(e);
        return res.json({ status: false, text: 'خطایی پیش آمده' });
    }
}));
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
app.use('/dashboard', dashboard_route_1.dashboardRoute);
//dashboard routes
// app.use('/dashboard', dashboardRoute);
app.use('/error/404', (req, res) => {
    return res.render('error/404.ejs');
});
app.use('/error/403', (req, res) => {
    return res.render('error/403.ejs');
});
app.use('/', (_, res) => {
    return res.redirect('/dashboard/auth');
});
const PORT = process.env.PORT || 8800;
(0, db_1.default)().then(() => {
    console.log('mongo database connected');
    mqtt_1.default.getInstance().connect();
    app.listen(PORT, () => console.log(`server start at ${PORT}`));
});
