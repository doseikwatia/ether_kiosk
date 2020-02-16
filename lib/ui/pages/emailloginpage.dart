import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/store/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class EmailLoginPage extends StatefulWidget {
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  bool _isLoggingIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EtherKiosk'),
      ),
      body: Center(
          child: _isLoggingIn ? CircularProgressIndicator() : EmailLoginForm()),
    );
  }
}

class EmailLoginForm extends StatefulWidget {
  const EmailLoginForm({
    Key key,
  });

  @override
  _EmailLoginFormState createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 20, 0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
              validator:  (value) => value.isEmpty ? 'Required' : null,
              onSaved: (value) {
                _email = value.trim();
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password', icon: Icon(Icons.security)),
              validator: (value) => value.isEmpty ? 'Required' : null,
              onSaved: (value) {
                _password = value;
              },
            ),
            FlatButton(
              child: const Text('Login'),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;
                _formKey.currentState.save();
                var store = StoreProvider.of<AppState>(context);
                store.dispatch(
                    SignInWithEmailAction(_email, _password, context: context));
              }, //_LoginPageViewModel.onSigninWithEmailClicked(context), need to add the redux store action here.
              color: Colors.green,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
