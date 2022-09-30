export default class AhpValidator {
	static isValidDate(date: string | number): boolean {
		// if (typeof date === 'number') {
		// 	const timeStampRegex = /^\d{10}$|^\d{13}$/;
		// 	console.log(timeStampRegex.test(date.toString()));
		// 	return timeStampRegex.test(date.toString());
		// }

		const dateObject = new Date(date);

		return (
			dateObject instanceof Date &&
			!isNaN(dateObject.valueOf()) &&
			dateObject.getTime() > 0
		);
	}

	static isWeekDayArray(value: any) {
		if (!Array.isArray(value)) {
			// console.log('not array');
			return false;
		}

		if (value.length == 0) return true;

		return value.every(
			(v) =>
				typeof v === 'string' &&
				['sat', 'sun', 'mon', 'tue', 'wed', 'thr', 'fri'].includes(
					v.toLowerCase(),
				),
		);
	}

	static isTime(time: string) {
		return /^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(time);
	}

	static isNumber = (number:string) => /\d+/.test(number)

	static isMobileNumber = (mobile:string) => /09[0-9]{9}/.test(mobile)

	static validImageExtensions = (filename:string, extensions:string) => {
		const extension = filename.substring(
			filename.lastIndexOf('.') + 1,
			filename.length - 1
		)
		if (extension.toString().trim() == '') return false
		return extensions.includes(extension)
	}

	static isEmpty = (val:any) => {
		const typeOfVal: string = typeof val
		switch (typeOfVal) {
			case 'object':
				return val.length == 0 || !Object.keys(val).length
				break
			case 'string': {
				const str: string = val.trim()
				return str == '' || str == undefined || str == null || str == 'null'
				break
			}
			case 'number':
				return val == ''
				break
			default:
				return val == '' || val == undefined
		}
	}
}
