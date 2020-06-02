import 'package:meta/meta.dart';
enum UserState {
  Signed_In,
  Signing_In,
  Signed_Out,
  Signing_Out,
  Sign_In_Err,
  Sign_Out_Err
}
@immutable
class AuthInfo {
  final dynamic user;
  final UserState userState;
  final String errMsg;
  final String email;
  final String password;
  final String passwordConfirmation;
  AuthInfo(
      {this.user,
      this.userState = UserState.Signed_Out,
      this.errMsg = '',
      this.password,
      this.passwordConfirmation,
      this.email});

  AuthInfo copyWith(
      {dynamic user,
      UserState userState,
      String errMsg = '',
      String email,
      String password,
      String passwordConfirmation}) {
    return new AuthInfo(
        user: user ?? this.user,
        userState: userState ?? this.userState,
        errMsg: errMsg ?? this.errMsg,
        password: password ?? this.password,
        passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
        email: email ?? this.email);
  }
}
