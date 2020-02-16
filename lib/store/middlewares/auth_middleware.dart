import 'package:ether_kiosk/firebase.dart';
import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/models/authinfo.dart';
import 'package:ether_kiosk/store/actions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

import 'notification_middleware.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
  'email',
]);

final FacebookLogin _facebookLogin = FacebookLogin();
final List<Middleware<AppState>> authMiddlewares = [
  new TypedMiddleware<AppState, SignInWithGoogleAction>(
      _signInWithGoogleMiddleware),
  new TypedMiddleware<AppState, SignOutAction>(_signOutMiddleware),
  new TypedMiddleware<AppState, SignInWithFacebookAction>(
      _signInWithFacebookMiddleware),
  new TypedMiddleware<AppState, SignInWithEmailAction>(_signInWithEmail)
];

void _signInWithFacebookMiddleware(Store<AppState> store,
    SignInWithFacebookAction action, NextDispatcher next) async {
  store.dispatch(new UpdateAuthInfoAction(userState: UserState.Signing_In));
  FacebookLoginResult facebookLoginResult =
      await _facebookLogin.logIn(['email', 'public_profile']);
  Firebase.auth
      .signInWithCredential(FacebookAuthProvider.getCredential(
          accessToken: facebookLoginResult.accessToken
              .token)) //accessToken: facebookLoginResult.accessToken.token
      .then((result) {
    store.dispatch(UpdateAuthInfoAction(
        user: result.user, userState: UserState.Signed_In));
  }).catchError((err) {
    print('Error $err occured.');
    showNotification(action.context, store, 'An error occurred',
        notificationType: NotificationType.Toast);
    store.dispatch(new UpdateAuthInfoAction(
        user: null, userState: UserState.Sign_In_Err, errMsg: err.toString()));
  });
}

void _signInWithGoogleMiddleware(Store<AppState> store,
    SignInWithGoogleAction action, NextDispatcher next) async {
  store.dispatch(new UpdateAuthInfoAction(userState: UserState.Signing_In));
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  Firebase.auth
      .signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth
              .accessToken)) // accessToken: googleAuth.accessToken,idToken: googleAuth.idToken,
      .then((result) {
    store.dispatch(new UpdateAuthInfoAction(
        user: result.user, userState: UserState.Signed_In));
  }).catchError((err) {
    print('Error $err occured.');
    showNotification(action.context, store, 'An error occurred',
        notificationType: NotificationType.Toast);
    store.dispatch(new UpdateAuthInfoAction(
        user: null, userState: UserState.Sign_In_Err, errMsg: err.toString()));
  });
}

void _signOutMiddleware(
    Store<AppState> store, SignOutAction action, NextDispatcher next) async {
  store.dispatch(new UpdateAuthInfoAction(userState: UserState.Signing_Out));
  Firebase.auth.signOut().then((user) {
    store.dispatch(new UpdateAuthInfoAction(userState: UserState.Signed_Out));
  }).catchError((err) {
    print('Error $err occured.');
    showNotification(action.context, store, 'An error occurred',
        notificationType: NotificationType.Toast);
    store.dispatch(new UpdateAuthInfoAction(
        userState: UserState.Sign_Out_Err, errMsg: err.toString()));
  });
}

void _signInWithEmail(
    Store<AppState> store, SignInWithEmailAction action, next) {
  store.dispatch(new UpdateAuthInfoAction(userState: UserState.Signing_In));
  Firebase.auth.signInWithEmailAndPassword(email: action.email, password: action.password).then((user) {
    print(user);
  }).catchError((err) {
    print(err);
  });
}
