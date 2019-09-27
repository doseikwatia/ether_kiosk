import 'package:ether_kiosk/models/authinfo.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final AuthInfo authInfo;
  AppState({this.authInfo});

  AppState copyWith({AuthInfo authInfo}) {
    return AppState(
      authInfo: authInfo ?? this.authInfo,
    );
  }

  factory AppState.initial() {
    return AppState(
      authInfo: AuthInfo(),
    );
  }
}
