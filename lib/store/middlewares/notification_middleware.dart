import 'package:ether_kiosk/models/appstate.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:toast/toast.dart';
import '../actions.dart';

final List<Middleware<AppState>> notificationMiddlewares = [
  new TypedMiddleware<AppState, ShowNotificationAction>(
      _showNotificationMiddleware)
];
enum NotificationType { SnackBar, Toast }
void _showNotificationMiddleware(
    Store<AppState> store, ShowNotificationAction action, NextDispatcher next) {
  switch (action.notificationType) {
    case NotificationType.SnackBar:
      Scaffold.of(action.context).showSnackBar(SnackBar(
        content: Text(action.message),
        duration: Duration(milliseconds: action.duration),
      ));
      break;
    case NotificationType.Toast:
      Toast.show(action.message, action.context,
          duration: action.duration ~/ 1000);
      break;
  }
}
void showToast(BuildContext ctx, Store<AppState> store, String message,
{duration = 2500})
{
  showNotification(ctx, store, message, duration:duration, notificationType: NotificationType.Toast);
}
void showSnackBar(BuildContext ctx, Store<AppState> store, String message,
{duration = 2500}){
  showNotification(ctx, store, message, duration: duration, notificationType: NotificationType.SnackBar);
}
void showNotification(
    BuildContext ctx, Store<AppState> store, String message,
    {duration = 2500, notificationType = NotificationType.SnackBar}) {
  if (ctx != null)
    store.dispatch(ShowNotificationAction(ctx, message,
        notificationType: notificationType, duration: duration));
}