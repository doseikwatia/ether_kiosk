import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/store/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterationForm extends StatelessWidget {
  final void Function() closeFn;
  RegisterationForm({
    Key key,
    this.closeFn,
  }) : super(key: key);

  final _passwordValidator = MultiValidator([
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    RequiredValidator(errorText: 'password is required')
  ]);
  final _emailValidator = MultiValidator([
    EmailValidator(errorText: 'enter a valid email'),
    RequiredValidator(errorText: 'email is required')
  ]);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var formKey = GlobalKey<FormState>();
    String username, password, confirmpassword;
    return Container(
        margin: EdgeInsets.all(15),
        height: 300,
        child: Form(
            key: formKey,
            child: Column(children: <Widget>[
              TextFormField(
                onChanged: (v) => username = v,
                decoration: InputDecoration(
                    labelText: 'Email', icon: Icon(Icons.email)),
                validator: _emailValidator,
                controller: TextEditingController(),
              ),
              TextFormField(
                  onChanged: (v) => password = v,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password', icon: Icon(Icons.security)),
                  validator: _passwordValidator),
              TextFormField(
                  onChanged: (v) => confirmpassword = v,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Repeat', icon: Icon(Icons.verified_user)),
                  validator: (value) => password.compareTo(confirmpassword) == 0
                      ? null
                      : 'does not match password'),
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  children: <Widget>[
                    Spacer(
                      flex: 2,
                    ),
                    FlatButton(
                        color: Colors.grey,
                        textColor: Colors.white,
                        onPressed: closeFn,
                        child: Text('Back')),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        formKey.currentState.reset();
                      },
                      child: Text("Reset"),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    FlatButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          store.dispatch(RegisterWithUsernameAndPasswordAction(
                              username, password, username,
                              context: context));
                        }
                      },
                      child: Text("Register"),
                      color: Colors.green,
                      textColor: Colors.white,
                    )
                  ],
                ),
              )
            ])));
  }
}
