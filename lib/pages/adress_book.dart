import 'package:ecommerce_app/componants/addres_card.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'add_new_address.dart';

class AddressBook extends StatelessWidget {
  static const String id = 'address';
  @override
  Widget build(BuildContext context) {
    List<UserModel> _userInfo = Provider.of<List<UserModel>>(context);
    List addressList = _userInfo[0].address;

    //List firstTwo = addressList.sublist(0, 2);

    ///make only one item in a list equals to true
    addressList[1]['default'] = false;

    ///List addressBook = [];
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Your Addresses',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: addressList == null
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: List.generate(
                        2,
                        (index) => AddressCard(
                          name: addressList[index]['name'],
                          region: addressList[index]['region'],
                          town: addressList[index]['town'],
                          address: addressList[index]['address'],
                          phone: addressList[index]['phone'],
                          defaultAddress: !addressList[index]['default']
                              ? ''
                              : 'Default Address',
                        ),
                      ),
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
      ),
    );
  }
}
