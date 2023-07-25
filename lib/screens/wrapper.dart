// ignore_for_file: unused_import, unnecessary_null_comparison

import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);
    print(user);

    //return either home or authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}