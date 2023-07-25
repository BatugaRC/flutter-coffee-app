// ignore_for_file: prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import "package:provider/provider.dart";

import '../../models/brew.dart';
import '../../models/user.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0,
            ),
            child: const SettingsForm(),
          );
        },
      );
    }

    final user = Provider.of<AppUser>(context);
    return StreamProvider<List<Brew>?>.value(
      initialData: null,
      value: DatabaseService(uid: user.uid).brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.person,
              ),
              label: const Text("Logout"),
              onPressed: () async {
                bool shouldNavigate = await _auth.signOut();
                if (shouldNavigate) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/welcome/",
                    (route) => false,
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.brown[900],
              ),
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: const Icon(Icons.coffee_sharp),
              label: const Text("Coffee"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.brown[900],
              ),
            )
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
