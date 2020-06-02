import 'package:flutter/material.dart';

class StoreSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return[ IconButton(
      icon: Icon(Icons.clear), 
      onPressed: () {
        close(context, null);
      },
    ),
    ];
    
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    return Container();
  }
}

