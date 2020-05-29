import 'package:ether_kiosk/constants.dart';
import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/store/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/gestures.dart';
class LoginForm extends StatelessWidget {
  final void Function() closeFn;
  LoginForm({
    Key key,
    this.closeFn,
  }) : super(key: key);

  createPasswordResetDialog(BuildContext context){
    TextEditingController custcontrol = TextEditingController();
    return showDialog(context: context, builder:(context){
      return AlertDialog(
        title: Text('Request Password Reset link',style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold) ),
        content: TextFormField(
          controller:  custcontrol,
          decoration: InputDecoration(
            hintText: 'input email'
          )
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 3.0,
            child: Text('Submit'),
            color: Colors.green,
            onPressed: (){}, //TODO: function will need to make a call to parse backend and send a reset password email to the users email address
          )
        ],

      );

    });
  }
  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    String email, password;
    var formKey = GlobalKey<FormState>();
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 20, 0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email', icon: Icon(Icons.email)),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'email is required'),
                        EmailValidator(errorText: 'enter a valid email')
                      ]),
                      onChanged: (v) => email = v,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password', icon: Icon(Icons.security)),
                      validator: (value) => value.isEmpty ? 'Required' : null,
                      onChanged: (v) => password = v,
                    ),
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
                              child: Text('New User')),
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              formKey.currentState.reset();
                            },
                            child: Text('Reset'),
                            color: Colors.red,
                            textColor: Colors.white,
                          ),
                          Spacer(),
                          FlatButton(
                            child: const Text('Login'),
                            onPressed: () {
                              if (formKey.currentState.validate())
                                store.dispatch(
                                    SigninWithUsernameAndPasswordAction(
                                        email, password,
                                        context: context));
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                          ),
   
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
          child: RichText(
            text:TextSpan(
              text: 'Forgot Password?',
              style: TextStyle(fontSize: 15, color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = () {
                createPasswordResetDialog(context);
              }
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Constants.register_or_sigin,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Spacer(),
            IconButton(
              icon: Icon(FontAwesomeIcons.google),
              iconSize: 30.0,
              onPressed: () =>
                  store.dispatch(SignInWithGoogleAction(context: context)),
              color: Colors.red,
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.facebook),
              iconSize: 30.0,
              onPressed: () =>
                  store.dispatch(SignInWithFacebookAction(context: context)),
              color: Colors.indigo,
            ),
            Spacer()
          ],
        )
      ],
    );
  }
}
