import 'package:ether_kiosk/constants.dart';
import 'package:flutter/material.dart';

import 'loginform.dart';
import 'registrationform.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

enum Mode { Login, Register }

class _AuthenticationPageState extends State<AuthenticationPage> {
  Mode _mode;
  
  @override
  void initState() {
    _mode = Mode.Login;
    super.initState();
  }

  void switchMode() {
    setState(() {
      _mode = _mode == Mode.Login ? Mode.Register : Mode.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Constants.app_name),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: _mode == Mode.Login ? LoginForm(closeFn: switchMode,) : RegisterationForm(closeFn:switchMode),
            ),
          ),
        ));
  }
}
