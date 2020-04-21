import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid_assistant_app/models/wash.dart';
import 'package:covid_assistant_app/src/global_blocs/app_bloc.dart';

class covidEntryTile extends StatelessWidget {
  const covidEntryTile({
    Key key,
    @required this.drink,
  }) : super(key: key);

  final Wash drink;

  @override
  Widget build(BuildContext context) {
    final washBloc = Provider.of<AppBloc>(context).washBloc;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      // Can implement undo feature
      onDismissed: (direction) => washBloc.removeWash(drink),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
            ),
          ),
        ),
        child: ListTile(
          title: Text(drink.amount.toString()),
          subtitle: Text(drink.date.toString().substring(0, 10)),
        ),
      ),
    );
  }
}
