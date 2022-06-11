var db = connect('mongodb://mongo_admin:Imfn7Tndq@localhost:27017/admin');

db = db.getSiblingDB('chisco'); // we can not use "use" statement here to switch db

db.createUser({
	user: 'ahp',
	pwd: 'HqHQgHOu',
	roles: [{ role: 'readWrite', db: 'chisco' }],
	passwordDigestor: 'server',
});
