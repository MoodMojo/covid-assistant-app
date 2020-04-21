import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covid_assistant_app/models/wash.dart';
import 'package:covid_assistant_app/services/firestore/firestore_constants.dart';

class FirestoreWashService {
  /// Gets all the drinks of the day the date is provided
  static Future<Stream<QuerySnapshot>> getWashsStream(DateTime date) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();

    final morningDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final nightDate = DateTime(date.year, date.month, date.day + 1, 0, 0, 0);

    final drinksCollectionStream = Firestore.instance
        .collection(FirestoreConstants.userCollection)
        .document(firebaseUser.uid)
        .collection(FirestoreConstants.drinkCollection)
        .where('date', isGreaterThan: morningDate)
        .where('date', isLessThan: nightDate)
        .snapshots();
    return drinksCollectionStream;
  }

  static Future<void> drinkcovid(Wash drink) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    final drinksCollection = Firestore.instance
        .collection(FirestoreConstants.userCollection)
        .document(firebaseUser.uid)
        .collection(FirestoreConstants.drinkCollection);

    drinksCollection.add(drink.toJson());
  }

  static Future<void> removeWash(Wash drink) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection(FirestoreConstants.userCollection)
        .document(firebaseUser.uid)
        .collection(FirestoreConstants.drinkCollection)
        .document(drink.id)
        .delete();
  }
}
