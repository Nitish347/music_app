import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(BuildContext context, String msg){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg)),
  );
}