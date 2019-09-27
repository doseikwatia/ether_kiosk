import 'package:ether_kiosk/constants.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (lctx) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(lctx).openDrawer(),
          ),
        ),
        title: const Text(Constants.app_name),
        centerTitle: true,
      ),
      body: Center(
        child: const Text('HomePage'),
      ),
      drawer: Menu(),
    );
  }
}
