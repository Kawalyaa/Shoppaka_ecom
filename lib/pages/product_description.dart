import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  static const String id = 'description';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text(
                  'Key Features',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text(
                  'Specification',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),

                  //TODO web view
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
