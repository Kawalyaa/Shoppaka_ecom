import 'package:ecommerce_app/model/pickup_location_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SinglePickupLocation extends StatelessWidget {
  final String placeName;
  final String location;
  final String openingHours;
  final int shippingFee;
  final Function navigatorCallback;

  SinglePickupLocation(
      {this.placeName,
      this.location,
      this.openingHours,
      this.shippingFee,
      this.navigatorCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.50,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              placeName,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              location,
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
            Text(
              'Opening Hours',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 18.0),
            ),
            Text(openingHours,
                style: TextStyle(color: Colors.black54, fontSize: 16.0)),
            Text(
              'Shipping Fee',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            SizedBox(height: 5.0),
            Text('UGX $shippingFee',
                style: TextStyle(
                    color: kColorRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: TextButton(
                  child: Text(
                    'SELECT PICKUP STATION',
                    style: TextStyle(color: kColorRed),
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      [
                        PickupLocationModel(
                          placeName: placeName,
                          location: location,
                          openingHours: openingHours,
                          shippingFee: shippingFee,
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
