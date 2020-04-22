import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:covid_assistant_app/models/wash.dart';
import 'package:covid_assistant_app/services/firestore/firestore_wash_service.dart';
import 'package:covid_assistant_app/src/global_blocs/bloc_base.dart';

class WashBloc implements BlocBase {
  StreamSubscription _handStreamSubscription;
  List<Wash> _handsToday = List();
  int _selectedWashAmount = 200;

  final _handController = BehaviorSubject<List<Wash>>();
  Function(List<Wash>) get _inWashs => _handController.sink.add;
  Stream<List<Wash>> get outWashs => _handController.stream;

  final _selectedWashAmountController = BehaviorSubject<int>();
  Function(int) get _inSelectedAmount => _selectedWashAmountController.sink.add;
  Stream<int> get outSelectedAmount => _selectedWashAmountController.stream;

  Stream<int> get outWashsAmount {
    return outWashs.map((hands) => hands.fold<int>(0, (totalAmount, hand) => totalAmount + hand.amount));
  }

  Future<void> init() async {
    final handStream = await FirestoreWashService.getWashsStream(DateTime.now());
    _handStreamSubscription = handStream.listen((querySnapshot) {
      _handsToday = querySnapshot.documents.map((doc) => Wash.fromDb(doc.data, doc.documentID)).toList();
      _inWashs(_handsToday);
    });

    _inSelectedAmount(_selectedWashAmount);
  }

  Future<void> handcovid() async {
    final hand = Wash(DateTime.now(), 1);
    FirestoreWashService.handcovid(hand);
  }

  Future<void> removeWash(Wash hand) async {
    FirestoreWashService.removeWash(hand);
  }

  set setWashAmount(int amount) {
    _selectedWashAmount = amount;
    _inSelectedAmount(_selectedWashAmount);
  }

  @override
  void dispose() {
    _handController.close();
    _selectedWashAmountController.close();
    _handStreamSubscription.cancel();
  }
}
