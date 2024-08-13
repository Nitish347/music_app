import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingControllers extends GetxController {
  RxInt index = 0.obs;
  void onChangedIndex() {
    index.value++;
  }
}
