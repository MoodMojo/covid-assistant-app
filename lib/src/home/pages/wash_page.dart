import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid_assistant_app/models/wash.dart';
import 'package:covid_assistant_app/src/global_blocs/app_bloc.dart';
import 'package:covid_assistant_app/src/widgets/buttons/circle_wash_button.dart';
import 'package:covid_assistant_app/src/widgets/wash_entry_tile.dart';
import 'package:covid_assistant_app/src/widgets/wash_today_label.dart';

class WashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final washBlock = Provider.of<AppBloc>(context).washBloc;
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              covidTodayLabel(),
              CircleButton(),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: StreamBuilder<List<Wash>>(
            stream: washBlock.outWashs,
            initialData: [],
            builder: (context, snapshot) {
              final hands = snapshot.data;
              return ListView.builder(
                itemCount: hands.length,
                itemBuilder: (context, index) {
                  final hand = hands[index];
                  return covidEntryTile(hand: hand);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
