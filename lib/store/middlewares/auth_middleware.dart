import 'dart:convert';

import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/models/authinfo.dart';
import 'package:ether_kiosk/store/actions.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'notification_middleware.dart';
import 'package:random_string/random_string.dart';

final FacebookLogin _facebookLogin = FacebookLogin();
final List<Middleware<AppState>> authMiddlewares = [
  new TypedMiddleware<AppState, SignInWithGoogleAction>(
      _signInWithGoogleMiddleware),
  new TypedMiddleware<AppState, SignOutAction>(_signOutMiddleware),
  new TypedMiddleware<AppState, SignInWithFacebookAction>(
      _signInWithFacebookMiddleware),
  new TypedMiddleware<AppState, RegisterWithUsernameAndPasswordAction>(
      _registerWithUsernameAndPassword),
  new TypedMiddleware<AppState, SigninWithUsernameAndPasswordAction>(
      _signinWithUsernameAndPassword)
];

void _signinWithUsernameAndPassword(Store<AppState> store,
    SigninWithUsernameAndPasswordAction action, NextDispatcher next) async {
  var user =
      ParseUser.createUser(action.username, action.password, action.username);
  user.login().then((response) {
    if (!response.success) {
      showNotification(action.context, store, response.error.message,
          notificationType: NotificationType.Toast);
      return;
    }
    return store.dispatch(UpdateAuthInfoAction(
        user: response.result, userState: UserState.Signed_In));
  }).catchError((err) {
    print('Error $err occured.');
    showNotification(action.context, store, 'An error occurred',
        notificationType: NotificationType.Toast);
    store.dispatch(new UpdateAuthInfoAction(
        user: null, userState: UserState.Sign_In_Err, errMsg: err.toString()));
  });
}

void _registerWithUsernameAndPassword(Store<AppState> store,
    RegisterWithUsernameAndPasswordAction action, NextDispatcher next) async {
  var user =
      ParseUser.createUser(action.username, action.password, action.email);
  user.signUp().then((response) {
    if (!response.success) {
      showNotification(action.context, store, response.error.message,
          notificationType: NotificationType.Toast);
      return;
    }
    return store.dispatch(UpdateAuthInfoAction(
        user: response.result, userState: UserState.Signed_In));
  }).catchError((err) {
    print('Error $err occured.');
    showNotification(action.context, store, 'An error occurred',
        notificationType: NotificationType.Toast);
    store.dispatch(new UpdateAuthInfoAction(
        user: null, userState: UserState.Sign_In_Err, errMsg: err.toString()));
  });
}

void _signInWithFacebookMiddleware(Store<AppState> store,
    SignInWithFacebookAction action, NextDispatcher next) async {
  store.dispatch(new UpdateAuthInfoAction(userState: UserState.Signing_In));
  //Logging in into facebook
  FacebookLoginResult result =
      await _facebookLogin.logIn(['email', 'public_profile']);
  if (result.status != FacebookLoginStatus.loggedIn) return;
  var authData = facebook(result.accessToken.token, result.accessToken.userId,
      result.accessToken.expires);
  //Check if user is already signed in
  var currentUser = await ParseUser.currentUser();
  if (currentUser != null) {
    store.dispatch(UpdateAuthInfoAction(
        user: currentUser as ParseUser, userState: UserState.Signed_In));
    return;
  }
  ParseUser.loginWith('facebook', authData).then((response) async {
    if (!response.success) {
      showNotification(action.context, store, response.error.message,
          notificationType: NotificationType.Toast);
      return;
    }
    var user = response.result;
    if (user['full_name'] == null) {
      //Getting user profile from facebook
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
      final profile = jsonDecode(graphResponse.body);
      user['full_name'] = profile['name'];
      user['first_name'] = profile['first_name'];
      user['last_name'] = profile['last_name'];
      (user as ParseUser).save();
    }
    store.dispatch(UpdateAuthInfoAction(
        user: response.result as ParseUser,
        userState:
            response.success ? UserState.Signed_In : UserState.Signed_Out));
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
  GoogleSignInAccount googleUser = await GoogleSignIn(scopes: [
    'email',
  ]).signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  var idTokenPayload = Jwt.parseJwt(googleAuth.idToken);
  ParseUser.loginWith('google', {
    'access_token': googleAuth.accessToken,
    'id': idTokenPayload['sub'],
    'id_token': googleAuth.idToken,
  }).then((response) {
    if (!response.success) {
      showNotification(action.context, store, response.error.message,
          notificationType: NotificationType.Toast);
      return;
    }
    store.dispatch(new UpdateAuthInfoAction(
        user: response.result,
        userState:
            response.success ? UserState.Signed_In : UserState.Signed_Out));
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
  store.state.authInfo.user.logout(deleteLocalUserData: true);
}
