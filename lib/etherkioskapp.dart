import 'dart:async';

import 'package:ether_kiosk/routes.dart';
import 'package:ether_kiosk/store/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'constants.dart';
import 'firebase.dart';
import 'models/appstate.dart';
import 'models/authinfo.dart';
import 'package:redux/redux.dart';

class EtherKioskApp extends StatefulWidget {
  final Store<AppState> store;
  EtherKioskApp(this.store);
  @override
  _EtherKioskAppState createState() => _EtherKioskAppState();
}

class _EtherKioskAppState extends State<EtherKioskApp>
    with WidgetsBindingObserver {
  StreamSubscription<FirebaseUser> _firebaseUsrSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //subscribing to auth events
    _firebaseUsrSubscription = Firebase.auth.onAuthStateChanged.listen((result) {
      widget.store.dispatch(UpdateAuthInfoAction(
          user: result.user,
          userState:
              result.user == null ? UserState.Signed_Out : UserState.Signed_In));
    }, onError: (err) {
      widget.store.dispatch(
          UpdateAuthInfoAction(user: null, userState: UserState.Signed_Out));

      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: StoreConnector<AppState, UserState>(
            converter: (store) => store.state.authInfo.userState,
            builder: (context, vm) {
              return MaterialApp(
                title: Constants.app_name,
                theme: ThemeData(
                  primarySwatch: Colors.green,
                ),
                routes: routes,
                home: routes[(vm == UserState.Signed_In ? '/home' : '/login')](
                    context),
              );
            }));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _firebaseUsrSubscription?.cancel();
    super.dispose();
  }
}
