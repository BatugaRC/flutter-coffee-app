// ignore_for_file: unused_field, use_build_context_synchronously

import "package:brew_crew/models/user.dart";
import "package:brew_crew/services/database.dart";
import "package:brew_crew/shared/constants.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    "Update your brew settings.",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration.copyWith(
                        hintText: "Please enter your name"),
                    validator: (val) =>
                        val!.isEmpty ? "Please enter your name" : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData?.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _currentSugars = value!),
                  ),
                  //slider
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData!.strength!],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData!.strength!],
                    label: "Strength: $_currentStrength",
                    value: (_currentStrength ?? userData?.strength)!.toDouble(),
                    onChanged: (value) =>
                        setState(() => _currentStrength = value.round()),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData!.sugars!,
                        _currentName ?? userData!.name!,
                        _currentStrength ?? userData!.strength!,
                      );
                        Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
