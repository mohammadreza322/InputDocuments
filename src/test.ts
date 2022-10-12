var request = require('request');
var options = {
	'method': 'GET',
	'url': 'http://chisco.tech/api/user/',
	'headers': {
		'x-auth-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZDdjNTRlYzVlNGYxZTdkOGE0ODlkMiIsImlhdCI6MTY2NTUyMzQ3MSwiZXhwIjoxNjY1NTI3MDcxfQ.6TT2xh7jngMrB4T0w-SCl3Ure1HOp_lOgaOgfQt6on8',
		'Cookie': 'di_noissaes_mait=s%3AUNdSjQKu6Lbd5UHoKDMrNu9GLF1tWGZb.kE0fxS%2Fh5NYNU3%2BjyFnfR%2Br41bwLUMIjLRounNeLtE4'
	}
};
request(options, function (error, response) {
	if (error) throw new Error(error);
	console.log(response.body);
});
