export interface getFullNameInput {
	fullName: string;
}

export interface getUserInformationOutput {
	phoneNumber: string;
	fullName?: string;
	address?: string;
	birthday?: number;
}

export interface editUserProfileInput {
	fullName: string;
	phoneNumber: string;
	address?: string;
	birthday?: number;
}
