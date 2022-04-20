import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';

void toastSuccess({
  required String msg,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 18,
      backgroundColor: colorGreen,
      timeInSecForIosWeb: 5,
    );

void toastError({
  required String msg,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 18,
      backgroundColor: colorRed,
      timeInSecForIosWeb: 5,
    );
