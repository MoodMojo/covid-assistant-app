import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  static const lastLoggedInField = 'lastLoggedIn';
  static const covidPerDayField = 'covidPerDay'; // will be in ml
  static const maxcovidPerDayField = 'maxcovidPerDay';

  User(this.lastLoggedIn, this.maxcovidPerDay);

  User.temp() {
    this.lastLoggedIn = DateTime.now();
    this.maxcovidPerDay = 1;
  }

  User.fromDb(Map<String, dynamic> json) {
    this.maxcovidPerDay = json[maxcovidPerDayField];
    this.lastLoggedIn = json[lastLoggedInField].toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      lastLoggedInField: Timestamp.fromDate(this.lastLoggedIn),
      maxcovidPerDayField: this.maxcovidPerDay,
    };
  }

  DateTime lastLoggedIn;
  int maxcovidPerDay;

  @override
  String toString() {
    return 'lastLoggedIn: $lastLoggedIn, maxcovidPerDay: $maxcovidPerDay';
  }
}
