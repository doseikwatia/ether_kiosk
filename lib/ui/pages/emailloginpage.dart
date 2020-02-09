
import 'package:flutter/material.dart';


class EmailLoginPage extends StatefulWidget {

  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {

  GlobalKey<FormState> _formKey =GlobalKey<FormState>();
   bool _isLoggingIn =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EtherKiosk'),
      ),
      body: Stack(
        children: <Widget>[
          EmailLoginForm(
            formKey: _formKey, 
 
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child:_isLoggingIn ? CircularProgressIndicator(): Container(),
            ),
          )
        ],
   
      ),
      
    );
  }

}


class EmailLoginForm extends StatelessWidget {
  const EmailLoginForm({
    Key key,
     this.formKey,

  });

  final GlobalKey<FormState> formKey;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 20, 0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
              validator: (value)=> value.isEmpty ? 'Required':null,
              
            
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password', icon:Icon(Icons.security)),
              validator: (value)=> value.isEmpty ?'Required': null,
            
            ),
            FlatButton(
              child: const Text('Login'),
              onPressed:(){}, //_LoginPageViewModel.onSigninWithEmailClicked(context), need to add the redux store action here.
              color: Colors.green,
              textColor: Colors.white,
            )
          ],

        ),
      ),
    );
  }
}