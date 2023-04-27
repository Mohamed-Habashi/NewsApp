import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/news_cubit.dart';
import 'package:newsapp/cubit/news_states.dart';
import 'package:newsapp/layout/home_layout.dart';
import 'package:newsapp/shared/bloc_observer.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer=MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool? isDark= CacheHelper.getData(key: 'isDark');
  runApp( MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
   const MyApp( {super.key,required this.isDark});

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getPoliticsData()..changeThemeMode(
        fromShared: isDark,
      ),
      child:  BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch:Colors.deepPurple,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.deepPurple
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              primarySwatch:Colors.deepPurple ,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.deepPurple
              ),
              scaffoldBackgroundColor:Colors.black,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                unselectedItemColor: Colors.grey,
              ),

            ),
            themeMode:NewsCubit.get(context).isDark? ThemeMode.light: ThemeMode.dark,
            home: const HomeLayout(),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
