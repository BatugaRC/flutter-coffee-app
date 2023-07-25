// ignore_for_file: use_build_context_synchronously

import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();


  // text field state

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign In to Brew Crew"),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/register/",
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 20,
            ),
            label: const Text("Sign Up"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.brown[900],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: Form(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                onChanged: (value) {
                  setState(() => email = value);
                },
                decoration: textInputDecoration.copyWith(hintText: "Email"),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                onChanged: (value) {
                  setState(() => password = value);
                },
                decoration: textInputDecoration.copyWith(hintText: "Password"),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                ),
                onPressed: () async {
                  bool shouldNavigate = await _auth.login(
                    email,
                    password,
                  );
                  if (shouldNavigate) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/home/",
                      (route) => false,
                    );
                  }
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
