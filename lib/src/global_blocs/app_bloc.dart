import 'package:covid_assistant_app/src/global_blocs/bloc_base.dart';
import 'package:covid_assistant_app/src/global_blocs/wash_bloc.dart';
import 'package:covid_assistant_app/src/global_blocs/notification_bloc.dart';
import 'package:covid_assistant_app/src/global_blocs/user_bloc.dart';

class AppBloc implements BlocBase {
  UserBloc _userBloc;
  WashBloc _washBloc;
  NotificationBloc _notificationBloc;

  AppBloc() {
    _userBloc = UserBloc();
    _washBloc = WashBloc();
    _notificationBloc = NotificationBloc();
  }

  Future<void> init() async {
    await _userBloc.init();
    await _washBloc.init();
    await _notificationBloc.init();
  }

  UserBloc get userBloc => _userBloc;
  WashBloc get washBloc => _washBloc;
  NotificationBloc get notificationBloc => _notificationBloc;

  @override
  void dispose() {
    _userBloc.dispose();
    _washBloc.dispose();
    _notificationBloc.dispose();
  }
}
