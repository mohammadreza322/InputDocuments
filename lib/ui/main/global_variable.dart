class  GlobalVariable{
  ///its singleton Class that contain one variable [isUserLogin]
  GlobalVariable._privateConstructor();

  static final GlobalVariable _instance = GlobalVariable._privateConstructor();

  static bool? isUserLogin =null;

}