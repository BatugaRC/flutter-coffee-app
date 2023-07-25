// ignore_for_file: prefer_const_constructors

import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/screens/welcome_view.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future <void> main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          "/login/":(context) => const SignIn(),
          "/register/":(context) => const Register(),
          "/home/": (context) => Home(),
          "/welcome/": (context) => const Welcome(),
        },
        ),
    );
  }
}
