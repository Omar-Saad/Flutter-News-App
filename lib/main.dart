
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_latest_news/shared/bloc_observer.dart';
import 'package:flutter_latest_news/shared/cubit/cubit.dart';
import 'package:flutter_latest_news/shared/cubit/states.dart';
import 'package:flutter_latest_news/shared/network/local/cahe_helper.dart';
import 'package:flutter_latest_news/shared/network/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_layout.dart';



 main() async {
   WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBool(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
   final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)
          => AppCubit()..changeMode(isDark: isDark),
        ),
        BlocProvider(create: (BuildContext context)
        => NewsCubit()..getTopHeadlines()
          ,),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (context, state) {

    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    primarySwatch:  Colors.red,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
    color: Colors.black,
    ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 20.0,
    ),
    textTheme: TextTheme(
    bodyText1: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    ),
    ),

    ),

    darkTheme: ThemeData(
    primarySwatch:  Colors.red,
    scaffoldBackgroundColor: HexColor('#121212'),

    appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: HexColor('#121212'),
    statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('#121212'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
    color: Colors.white,
    ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('#121212'),
    elevation: 20.0,
    ),
    textTheme: TextTheme(
    bodyText1: TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    ),

    ),

    ),
    themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
    home: NewsLayout(),
    );
    },
      listener: (context, state) {},
    ),

    );
  }
}



