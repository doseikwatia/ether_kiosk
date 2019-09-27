import 'package:ether_kiosk/constants.dart';
import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/store/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _LoginPageViewModel>(
      converter: (Store<AppState> store) => _LoginPageViewModel(store),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(Constants.app_name),
            centerTitle: true,
          ),
          body: Center(
              child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Constants.register_or_sigin,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Spacer(),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.google),
                      iconSize: 70.0,
                      onPressed: () =>
                          viewModel.onSignInWithGoogleClicked(context),
                      color: Colors.red,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebook),
                      iconSize: 70.0,
                      onPressed: () =>
                          viewModel.onSingInWithFacebookClicked(context),
                      color: Colors.indigo,
                    ),
                    Spacer()
                  ],
                )
              ],
            ),
          )),
        );
      },
    );
  }
}

class _LoginPageViewModel {
  Store<AppState> store;
  _LoginPageViewModel(this.store);

  void onSignInWithGoogleClicked(BuildContext ctx) =>
      store.dispatch(SignInWithGoogleAction(context: ctx));

  void onSingInWithFacebookClicked(BuildContext ctx) =>
      store.dispatch(SignInWithFacebookAction(context: ctx));
}
