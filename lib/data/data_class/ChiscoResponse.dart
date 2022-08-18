class ChiscoResponse{
  final bool status;
  final int? code;
  final dynamic object;
  final String? errorMessage;

  ChiscoResponse( {required this.status,required this.code, this.object,this.errorMessage='',});

}