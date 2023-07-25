import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text("Welcome to Brew Crew!"),
        backgroundColor: Colors.brown[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/register/",
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[600],
                fixedSize: const Size(215, 73),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 42),
            ElevatedButton(
              
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/login/",
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[600],
                fixedSize: const Size(215, 73),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
