import 'package:ether_kiosk/constants.dart';
import 'package:ether_kiosk/store/store_search.dart';
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: StoreSearch());
            },
          ),
        ],
      ),

      /*** The Content of the body is just a dummy and will be modified to 
       *  1. Display recently purchased items of a specific user
       *  2. Display trending items 
       *  3. Items you may like ( based on previous search and demographics)
       * ***/
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[  
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('You recently bought the following items...',
                 style: TextStyle(
                   fontSize: 12, 
                   color:Colors.black, 
                   fontWeight: FontWeight.bold
                  )
                ),
              ),          
              SizedBox(
                height: 100,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6_KUW89UHOJsj5CtbGQ-Ftu7iUsvHCS6muq4FrnnUxMj_mJ61'
                              ),
                          title: Text('Nike Mens Sports shoes',
                              style: TextStyle(
                                fontSize: 20, 
                                color: Colors.blue[300],
                                fontWeight: FontWeight.bold
                                 ),
                              ),
                              ),
                    ],
                  ),
                ),
              ),
             SizedBox(
                height: 100,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: Image.network(
                              'https://cdn.shopify.com/s/files/1/0020/0762/9883/products/DAUNAVIA-2018-Vintage-Women-s-Handbags-Famous-Fashion-Brand-Candy-Shoulder-Bags-Ladies-Totes-Simple-Trapeze_aa027778-9e1a-4c3c-a9a5-bca0c6040af6_400x.jpg?v=1532364154'
                              ),
                          title: Text('Womens Hand Bag',
                              style: TextStyle(
                                fontSize: 20, 
                                color: Colors.blue[300],
                                fontWeight: FontWeight.bold
                                 ),
                              ),
                              ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Menu(),
    );
  }
}
