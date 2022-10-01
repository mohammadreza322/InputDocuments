/// this data class is for parsing all response in to the One
/// and that's because more flexibility in get get request response

class ChiscoResponse{
  final bool status;
  final int? code;
  final dynamic object;
  final String? errorMessage;

  ChiscoResponse( {required this.status,required this.code, this.object,this.errorMessage='',});

}