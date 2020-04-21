import 'package:cloud_firestore/cloud_firestore.dart';

class Wash {
  static const amountField = 'amount'; // will be in ml
  static const dateField = 'date';

  Wash(this.date, this.amount);

  Wash.temp() {
    this.date = DateTime.now();
    this.amount = 0;
  }

  Wash.fromDb(Map<String, dynamic> json, String id) {
    this.id = id;
    this.amount = json[amountField];
    this.date = json[dateField].toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      amountField: this.amount,
      dateField: Timestamp.fromDate(this.date),
    };
  }

  @override
  String toString() {
    return 'amount: $amount, date: $date';
  }

  String id;
  int amount;
  DateTime date;
}
