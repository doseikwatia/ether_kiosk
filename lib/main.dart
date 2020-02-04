import 'package:ether_kiosk/etherkioskapp.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'firebase.dart';
import 'models/appstate.dart';
import 'store/index.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<Middleware<AppState>> middlewares = []..addAll(authMiddlewares);
  final store = new Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: middlewares);
  await Future.wait([Firebase.initialize()]).catchError((err) {
    print('an error occurred $err');
  });
  runApp(EtherKioskApp(store));
}
