import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:covid_assistant_app/models/wash.dart';
import 'package:covid_assistant_app/services/firestore/firestore_wash_service.dart';
import 'package:covid_assistant_app/src/global_blocs/bloc_base.dart';

class WashBloc implements BlocBase {
  StreamSubscription _drinkStreamSubscription;
  List<Wash> _drinksToday = List();
  int _selectedWashAmount = 200;

  final _drinkController = BehaviorSubject<List<Wash>>();
  Function(List<Wash>) get _inWashs => _drinkController.sink.add;
  Stream<List<Wash>> get outWashs => _drinkController.stream;

  final _selectedWashAmountController = BehaviorSubject<int>();
  Function(int) get _inSelectedAmount => _selectedWashAmountController.sink.add;
  Stream<int> get outSelectedAmount => _selectedWashAmountController.stream;

  Stream<int> get outWashsAmount {
    return outWashs.map((drinks) => drinks.fold<int>(0, (totalAmount, drink) => totalAmount + drink.amount));
  }

  Future<void> init() async {
    final drinkStream = await FirestoreWashService.getWashsStream(DateTime.now());
    _drinkStreamSubscription = drinkStream.listen((querySnapshot) {
      _drinksToday = querySnapshot.documents.map((doc) => Wash.fromDb(doc.data, doc.documentID)).toList();
      _inWashs(_drinksToday);
    });

    _inSelectedAmount(_selectedWashAmount);
  }

  Future<void> drinkcovid() async {
    final drink = Wash(DateTime.now(), 1);
    FirestoreWashService.drinkcovid(drink);
  }

  Future<void> removeWash(Wash drink) async {
    FirestoreWashService.removeWash(drink);
  }

  set setWashAmount(int amount) {
    _selectedWashAmount = amount;
    _inSelectedAmount(_selectedWashAmount);
  }

  @override
  void dispose() {
    _drinkController.close();
    _selectedWashAmountController.close();
    _drinkStreamSubscription.cancel();
  }
}
