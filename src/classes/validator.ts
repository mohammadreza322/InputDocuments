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
			console.log('not array');
			return false;
		}

		if (value.length == 0) return true;

		const isArrayStringAndWeekDay = value.every(
			(v) =>
				typeof v === 'string' &&
				['sat', 'sun', 'mon', 'tue', 'wed', 'thr', 'fri'].includes(
					v.toLowerCase(),
				),
		);

		return isArrayStringAndWeekDay;
	}

	static isTime(time: string) {
		return /^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(time);
	}
}
