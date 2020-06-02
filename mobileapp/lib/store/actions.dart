import 'package:ether_kiosk/models/authinfo.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'middlewares/notification_middleware.dart';

class UpdateAuthInfoAction {
  final UserState userState;
  final ParseUser user;
  final String errMsg;
  final String email;
  final String password;
  final String passwordConfirmation;
  final BuildContext context;

  UpdateAuthInfoAction(
      {this.userState,
      this.user,
      this.errMsg = '',
      this.email,
      this.password,
      this.passwordConfirmation,
      this.context});
}

class SignInWithGoogleAction {
  final BuildContext context;

  SignInWithGoogleAction({this.context});
}

class SignOutAction {
  final BuildContext context;

  SignOutAction({this.context});
}

class SignInWithFacebookAction {
  final BuildContext context;

  SignInWithFacebookAction({this.context});
}


class SignInWithEmailAction {
  final BuildContext context;

  SignInWithEmailAction({this.context});
}


class ShowNotificationAction {
  final String message;
  final int duration;
  final NotificationType notificationType;
  final BuildContext context;

  ShowNotificationAction(this.context, this.message,
      {this.duration = 2500,
      this.notificationType = NotificationType.SnackBar});
}

class RegisterWithUsernameAndPasswordAction {
  final String username;
  final String password;
  final String email;
  final BuildContext context;
  RegisterWithUsernameAndPasswordAction(this.username, this.password, this.email, {this.context});
}

class SigninWithUsernameAndPasswordAction {
  final String username;
  final String password;
  final BuildContext context;
  SigninWithUsernameAndPasswordAction(this.username, this.password, {this.context});
}

class PasswordResetAction{
  final String email;
  final BuildContext context;
  PasswordResetAction(this.email, this.context);
}