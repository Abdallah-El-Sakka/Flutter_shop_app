import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Layout/profile_system/login_screen.dart';
import '../cache/shared_preferences.dart';


String capFirstLetter(String word) => word[0].toUpperCase() + word.substring(1);

void signOutUser(BuildContext context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {

    CacheHelper.removeData(key: 'name').then((value)
    {

      name  = '';
      token = '';

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen()
          )
      );
    });

  });
}

void showToast({
  required String msg,
  required ToastStates state
})
{
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 15.0
  );
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state)
{

  late Color color;

  switch(state)
  {

    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

String token = '';

String name = '';