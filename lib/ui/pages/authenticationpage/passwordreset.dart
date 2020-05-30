import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/store/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


class PasswordResetDialog extends StatelessWidget {
  PasswordResetDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var formKey = GlobalKey<FormState>();
    String email;
    TextEditingController custcontrol = TextEditingController();
    return AlertDialog(
      title: Text('Request Password Reset link',
          style: TextStyle(
              color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
      content: TextFormField(
          controller: custcontrol,
          decoration: InputDecoration(hintText: 'input email'),
          onChanged: (value) => email= value,
          ),
      actions: <Widget>[
        MaterialButton(
          elevation: 3.0,
          child: Text('Submit'),
          color: Colors.green,
          onPressed: () {
            //if(formKey.currentState.validate()){
              store.dispatch(PasswordResetAction(email, context));
            //}
             Navigator.pop(context);
          }, //TODO: function will need to make a call to parse backend and send a reset password email to the users email address
        )
      ],
    );
  }
}
