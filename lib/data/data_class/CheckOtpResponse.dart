class CheckOtpResponse {
  final String accessToken;
  final String details;
  final String message;
  final String refreshToken;

  CheckOtpResponse(
      {required this.accessToken,
      required this.details,
      required this.message,
      required this.refreshToken});

  factory CheckOtpResponse.fromJson(Map<String, dynamic> json) {
    return CheckOtpResponse(
      accessToken: json['accessToken'],
      details: json['details'],
      message: json['message'],
      refreshToken: json['refreshToken'],
    );
  }


}
