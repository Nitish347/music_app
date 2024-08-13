import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task1/helper/token_storage.dart';

import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware{
  checkAuth()async{
    String? token = await Tokens.getTokenLoggedIn();
    if(token!= null){
      Get.offAllNamed(Routes.HOME);
    }else{
      return;
    }
  }
  @override
  RouteSettings? redirect(String? route) {
    checkAuth();
    return null;
  }
}