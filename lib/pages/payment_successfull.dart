import 'package:flutter/material.dart';

import '../constants.dart';

class PaymentSuccessful extends StatelessWidget {
  static const String id = "paymentSuccessful";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Order Successful',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 35.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Card(
                shape: CircleBorder(),
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF00FF00),
                  size: 150.0,
                ),
              )),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              height: 45.0,
              minWidth: 200,
              color: Colors.blueGrey,
              onPressed: () {},
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('GO TO MY ORDERS'),
            ),
          )
        ],
      ),
    ));
  }
}
