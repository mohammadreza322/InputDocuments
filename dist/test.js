var request = require('request');
var options = {
    'method': 'GET',
    'url': 'http://185.204.197.144:8081/api/v4/auth_username/0a88fe91565319483795e73a7eba1a8345fe972e',
    'headers': {
        'Authorization': 'Basic MjBiZjUwMWJjMGZhNjpNekExTnpZd05UTTVPVGMwTURrM01Ea3pPRGd3T0RJMU5EUTVOVFV5T1RNMk9URw=='
    }
};
request(options, function (error, response) {
    if (error)
        throw new Error(error);
    console.log(response.body);
});
