import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid_assistant_app/src/global_blocs/app_bloc.dart';

class covidTodayLabel extends StatefulWidget {
  const covidTodayLabel({
    Key key,
  }) : super(key: key);

  @override
  _covidTodayLabelState createState() => _covidTodayLabelState();
}

class _covidTodayLabelState extends State<covidTodayLabel> with SingleTickerProviderStateMixin {
  AnimationController _fadeInController;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<AppBloc>(context).userBloc;
    final washBloc = Provider.of<AppBloc>(context).washBloc;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<int>(
        stream: userBloc.outMaxcovid,
        initialData: 0,
        builder: (context, snapshot) {
          final maxcovid = snapshot.data;
          return StreamBuilder<int>(
            stream: washBloc.outWashsAmount,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final covidAmount = snapshot.data;
                _fadeInController.forward();
                return AnimatedBuilder(
                  animation: _fadeInController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeInController.value,
                      child: Text(
                        '$covidAmount / ${maxcovid} washes',
                        style: Theme.of(context).textTheme.title,
                      ),
                    );
                  },
                );
              }
              return SizedBox(height: 24);
            },
          );
        },
      ),
    );
  }
}
