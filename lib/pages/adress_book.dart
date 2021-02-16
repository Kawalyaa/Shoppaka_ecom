import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants.dart';
import 'add_new_address.dart';

class AddressBook extends StatelessWidget {
  static const String id = 'address';
  @override
  Widget build(BuildContext context) {
    List adressBook = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Adress book',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'firstName lastName',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                  FlatButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, AddNewAddress.id),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: kColorRed),
                                    ),
                                  ),
                                ],
                              ),
                              Text('address'),
                              Text('additionalInfo'),
                              Text('region'),
                              Text('division'),
                              Text('phoneNumber'),
                              Text('defaultAddress'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Divider(
                            thickness: 2.0,
                          ),
                        ),
                        Center(
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'SELECT THIS ADDRESS',
                              style: TextStyle(color: kColorRed),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor: kColorRed,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddNewAddress.id);
                    },
                    child: Text(
                      'ADD NEW ADDRESS',
                      style: TextStyle(color: kColorRed),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _adressCard() => [];
}

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
