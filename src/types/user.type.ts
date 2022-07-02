export interface getFullNameInput {
	fullName: string;
}

export interface getUserInformationOutput {
	phoneNumber: string;
	fullName?: string;
	address?: string;
	birthday?: Date;
}
