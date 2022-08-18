import 'package:chisco/data/data_class/Token.dart';

class TokenSingleton extends TokenBase{

  static final TokenSingleton _instance=TokenSingleton._internal();

  TokenSingleton._internal(){
    update(token, refreshToken, detail);

  }

  factory TokenSingleton(){
    return _instance;
  }




}
