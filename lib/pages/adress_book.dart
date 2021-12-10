import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/componants/addres_card.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/pages/add_new_address2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'add_new_address.dart';

class AddressBook extends StatelessWidget {
  static const String id = 'address';

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    // List<UserModel> _userInfo = Provider.of<List<UserModel>>(context);
    // List addressList = _userInfo[0].address;
    // List addressList2 = _userInfo[0].address2;

    //List firstTwo = addressList.sublist(0, 2);

    ///make only one item in a list equals to true
    // addressList[1]['default'] = false;

    ///List addressBook = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Address book',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              _users.where('id', isEqualTo: _auth.currentUser.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(color: kColorRed),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      Text("Loading....", style: TextStyle(color: kColorRed)));
            }
            List snapData = snapshot.data.docs
                .map((DocumentSnapshot snap) =>
                    UserModel.fromSnapShot(snap.data()))
                .toList();

            List addressList = snapData[0].address;
            List addressList2 = snapData[0].address2;

            return SingleChildScrollView(
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

                  ///Address 1
                  addressList.isEmpty
                      ? Card(
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
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AddNewAddress.id);
                                  },
                                  child: Text(
                                    'ADD NEW ADDRESS',
                                    style: TextStyle(color: kColorRed),
                                  ))
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: List.generate(
                              addressList.length,
                              (index) => AddressCard(
                                name: addressList[index]['name'],
                                region: addressList[index]['region'],
                                town: addressList[index]['town'],
                                address: addressList[index]['address'],
                                phone: addressList[index]['phone'],
                                defaultAddress: !addressList[index]['default']
                                    ? ''
                                    : 'Default Address',
                                editCallback: () => Navigator.pushNamed(
                                    context, AddNewAddress.id),
                              ),
                            ),
                          ),
                        ),

                  ///Address 2
                  Container(
                    child: addressList2 == null
                        ? Container()
                        : Column(
                            children: List.generate(
                              addressList2.length,
                              (index) => AddressCard(
                                name: addressList2[index]['name'],
                                region: addressList2[index]['region'],
                                town: addressList2[index]['town'],
                                address: addressList2[index]['address'],
                                phone: addressList2[index]['phone'],
                                defaultAddress: !addressList2[index]['default']
                                    ? ''
                                    : 'Default Address',
                                editCallback: () => Navigator.pushNamed(
                                    context, AddAddress2.id),
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
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AddAddress2.id);
                            },
                            child: Text(
                              'ADD SECOND ADDRESS',
                              style: TextStyle(color: kColorRed),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
