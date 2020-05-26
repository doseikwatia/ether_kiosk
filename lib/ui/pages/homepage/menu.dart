import 'package:ether_kiosk/models/appstate.dart';
import 'package:ether_kiosk/store/index.dart';
import 'package:ether_kiosk/ui/pages/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    return SizedBox(
      width: 140,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
                height: 120,
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    '' // store.state.authInfo.user.photoUrl,
                  ),
                  radius: 30,
                )),
            Text(
              'Daniel Osei'  // store.state.authInfo.user.displayName
                  .split(' ')
                  .map((s) => '${s[0].toUpperCase()}${s.substring(1)}')
                  .join(' '),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            _MediaItem(
                title: 'My Orders',
                icon: Icons.shopping_cart,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyOrders(),
                      ),
                    )),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            _MediaItem(
                title: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                }),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            _MediaItem(
              title: 'Logout',
              icon: Icons.exit_to_app,
              onTap: () {
                store.dispatch(SignOutAction(context: context));
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

typedef void OnTap();

class _MediaItem extends StatelessWidget {
  final OnTap onTap;
  final IconData icon;
  final String title;
  final Color color;

  _MediaItem(
      {this.color,
      @required this.icon,
      @required this.onTap,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    var styleColor = color == null ? Theme.of(context).primaryColor : color;
    return InkWell(
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 30,
            color: styleColor,
          ),
          Text(
            title,
            style: TextStyle(color: styleColor),
          ),
        ],
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
