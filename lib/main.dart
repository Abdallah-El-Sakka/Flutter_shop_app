import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'Bloc/bloc_observer.dart';
import 'Dio/DioHelper.dart';
import 'Layout/profile_system/onBoard.dart';
import 'Layout/shopping_home/Nav_home.dart';
import 'cache/shared_preferences.dart';
import 'fixed_materials/fixed.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token')??token;

  print(token);

  runApp(MyApp());
}

class MyApp extends StatelessWidget
{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {

    bool isLogged = token != '' ;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aqua',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade100,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black
          )
        )
      ),
      home: isLogged ? NavHomeScreen() : OnBoardingScreen()
    );
  }
}
