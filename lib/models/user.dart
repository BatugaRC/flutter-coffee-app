class AppUser {
  final String uid;

  AppUser({required this.uid});
  
}

class UserData {
  final String? uid;
  final String? name;
  final String? sugars;
  final int? strength;

  UserData({this.uid, this.name, this.sugars, this.strength});
}