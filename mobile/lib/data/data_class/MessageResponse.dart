///give this data class for some of requests
class MessageResponse{
  final String message;

  MessageResponse({required this.message});

  factory MessageResponse.fromJson(Map<String,dynamic> json){
    return MessageResponse(message: json['message']);
  }
}