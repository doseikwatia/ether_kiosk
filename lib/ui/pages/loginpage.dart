import 'package:ether_kiosk/constants.dart';
import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/ui/widgets.dart/loginform.dart';
import 'package:ether_kiosk/ui/widgets.dart/registrationform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum Mode { Login, Register }

class _LoginPageState extends State<LoginPage> {
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
