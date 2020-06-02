import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/models/authinfo.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

AppState appReducer(AppState state, dynamic action) =>
    AppState(authInfo: authReducer(state.authInfo, action));

//Authentication Reducer
final Reducer<AuthInfo> authReducer = combineReducers<AuthInfo>(
    [new TypedReducer<AuthInfo, UpdateAuthInfoAction>(_updateAuthInfo)]);

AuthInfo _updateAuthInfo(AuthInfo state, UpdateAuthInfoAction action) {
  return state == null
      ? new AuthInfo(
          userState: action.userState,
          user: action.user,
          errMsg: action.errMsg,
          email: action.email,
          password: action.password,
          passwordConfirmation: action.passwordConfirmation)
      : state.copyWith(
          userState: action.userState,
          user: action.user,
          errMsg: action.errMsg,
          email: action.email,
          password: action.password,
          passwordConfirmation: action.passwordConfirmation);
}
