// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign Up to Brew Crew"),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/login/",
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 20,
            ),
            label: const Text("Sign In"),
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
                  bool shouldNavigate = await _auth.register(
                    email,
                    password,
                  );
                  if (shouldNavigate) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/login/",
                      (route) => false,
                    );
                  }
                },
                child: const Text(
                  "Register",
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
