import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/cubit/cubit.dart';
import 'package:twasl/screens/home/home.dart';
import 'package:twasl/share/network/local/cachhelper.dart';

import 'blocobserver.dart';
import 'screens/login/login-screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

   String? uId =CachHelper.getData(key: 'uId');
  Widget widget;


  if(uId !=null) {
    widget = HomeScreen();
  }else {
    widget = LoginScreen();
  }
  BlocOverrides.runZoned(
        () {
          runApp( MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget, }) : super(key: key);
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ChatCubit()..getUserData()..getAllUser()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twasl',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: startWidget,
      ),
    );
  }
}

