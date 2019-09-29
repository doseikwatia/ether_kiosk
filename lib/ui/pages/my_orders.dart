import 'package:ether_kiosk/ui/index.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        leading: Builder(
          builder: (_) => IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                )),
          ),
        ),
      ),
      body: Center(
        child: Text('Will show list of recent orders'),
      ),
    );
  }
}
