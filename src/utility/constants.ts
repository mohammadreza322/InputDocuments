export const mongoConnection: string =
	'mongodb://ahpUser:acb6ApFI5797@185.204.197.144:27017/chisco?authSource=admin&readPreference=primary&directConnection=true&ssl=false';

export const jsonWebTokenSecretKey: string =
	'CE1EF2B97E080294A562165650C850A3EBE452E08420ACEB6863E8543510FDEB';

export const accessTokenExpireTime: string = '10m';
export const refreshTokenExpireTime: string = '30d';

export const brokerUrl: string = 'mqtt://185.204.197.144:1883';
export const brokerUrlAPI: string = 'http://185.204.197.144:8081';
