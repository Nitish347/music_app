import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task1/helper/token_storage.dart';

import '../routes/app_routes.dart';

class OnBoardingMiddleware extends GetMiddleware{
checkFirst()async{
  String? token = await Tokens.getTokenOnBoarding();
  if(token!= null){
    Get.toNamed(Routes.LOGIN);
  }else{
    return;
  }
}
  @override
  RouteSettings? redirect(String? route) {
checkFirst();
    return null;
  }
}