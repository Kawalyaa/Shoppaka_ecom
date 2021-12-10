import 'package:cloud_firestore/cloud_firestore.dart';
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

/// TODO 1 create order model,2 get orders from firestore
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
        //.map((snaps) => snaps.docs.map((snap) => OrderModel.fromSnapShot(snap)).toList()),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(
              'Something went wrong',
              style: TextStyle(color: kColorRed),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading....", style: TextStyle(color: kColorRed));
          }
          var snapData = snapshot.data.docs
              .map((DocumentSnapshot snap) =>
                  OrderModel.fromSnapShot(snap.data()))
              .toList();
          return snapData.isEmpty
              ? Container(
                  child: Text('Empty'),
                )
              : ListView.builder(
                  itemBuilder: (context, int index) {
                    return SingleOrder(
                      ///TODO add order id in createOrder method
                      orderList: snapData[index].ordersList,
                      orderNumber: snapData[index].orderNumber,
                      orderStatus: snapData[index].orderStatus,
                      deliveryDate: snapData[index].deliveryDate,
                    );
                  },
                  itemCount: snapData.length,
                );
        },
      ),
    );
  }
}

class SingleOrder extends StatelessWidget {
  final List orderList;
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  SingleOrder(
      {this.orderList, this.orderNumber, this.orderStatus, this.deliveryDate});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: Column(
        children: [
          Card(
            child: Column(
              children: List.generate(
                orderList.length,
                (index) => ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(orderList[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(orderList[index]['name']),
                              Text(
                                'qty: ${orderList[index]['qty'].toString()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  decoration: BoxDecoration(
                      color: orderStatus == 'delivered'
                          ? Color(0xFF00FF00)
                          : orderStatus == 'sorting'
                              ? Colors.deepOrange
                              : Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: Text(
                      orderStatus,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                deliveryDate == '' ? Container() : Text('on $deliveryDate'),
                Text(
                  '# $orderNumber',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
