export default class AhpValidator {
	static isValidDate(date: string | number): boolean {
		if (typeof date === 'number') {
			const timeStampRegex = /^\d{10}$|^\d{13}$/;
			console.log(timeStampRegex.test(date.toString()));
			return timeStampRegex.test(date.toString());
		}

		const dateObject = new Date(date);

		return (
			dateObject instanceof Date &&
			!isNaN(dateObject.valueOf()) &&
			dateObject.getTime() > 0
		);
	}
}
