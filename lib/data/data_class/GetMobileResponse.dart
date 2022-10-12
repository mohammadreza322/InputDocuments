///after user entered code we will send request with these parameters

class GetMobileResponse {
  // final int? code;
  final String id;
  final bool isNewUser;
  final String message;
//todo isNewUser Don't Need After Test
  GetMobileResponse(
      {required this.id, required this.isNewUser, required this.message});

  factory GetMobileResponse.fromJson(Map<String, dynamic> json) {
    return GetMobileResponse(
      // code: json['code'],
      id: json['id'],
      isNewUser: json['isNewUser'],
      message: json['message'],
    );
  }
}
