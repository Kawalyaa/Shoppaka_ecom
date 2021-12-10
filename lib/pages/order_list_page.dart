import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/componants/single_order.dart';
import 'package:ecommerce_app/model/order_model.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class OrderList extends StatefulWidget {
  static const String id = 'orderList';
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('allOrders');
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 2.0,
              color: kColorRed,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    HomePage.id,
                  );
                },
                minWidth: 200.0,
                height: 30.0,
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reference
            .where('id', isEqualTo: _auth.currentUser.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                child: Text("Loading....", style: TextStyle(color: kColorRed)));
          }
          List snapData = snapshot.data.docs
              .map((DocumentSnapshot snap) =>
                  OrderModel.fromSnapShot(snap.data()))
              .toList();

          /// Sort incoming data by time
          snapData.sort((a, b) => b.time.compareTo(a.time));
          return snapData.isEmpty
              ? Container(
                  child: Center(
                      child: Text('No Order Data',
                          style: TextStyle(
                              color: kColorRed,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0))),
                )
              : ListView.builder(
                  itemBuilder: (context, int index) {
                    return SingleOrder(
                      orderList: snapData[index].ordersList,
                      orderNumber: snapData[index].orderNumber,
                      orderStatus: snapData[index].orderStatus,
                      deliveryDate: snapData[index].deliveryDate,
                      totalPrice: snapData[index].totalPrice,
                      orderedTime: snapData[index].time,
                    );
                  },
                  itemCount: snapData.length,
                );
        },
      ),
    );
  }
}
