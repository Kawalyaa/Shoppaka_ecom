import 'package:ecommerce_app/componants/single_pickup_location.dart';
import 'package:ecommerce_app/db/pickup_location_data.dart';
import 'package:ecommerce_app/model/pickup_location_model.dart';
import 'package:ecommerce_app/pages/checkout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PickupStation extends StatefulWidget {
  static const String id = 'PickupStation';
  @override
  _PickupStationState createState() => _PickupStationState();
}

class _PickupStationState extends State<PickupStation> {
  //TODO @@@@@@@@@@@@@@@@@ change List to list of objects  @@@@@@@@@@@@@@
  List<PickupLocationModel> pickupInfo = LocationData.pickupLocationData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pickup Station',
          style: TextStyle(color: Colors.black54),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 25.0, bottom: 2.0),
            child: Text('YOUR LOCATION',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Region',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Kampala Region',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'City',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('Central Business District')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  MaterialButton(
                    height: 45.0,
                    minWidth: double.infinity,
                    color: kColorRed,
                    onPressed: () {},
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text('CHANGE LOCATION'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 25.0, bottom: 5.0),
            child: Text('PICKUP STATIONS NEAR YOU',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: List.generate(
                  pickupInfo.length,
                  (index) => SinglePickupLocation(
                    placeName: pickupInfo[index].placeName,
                    location: pickupInfo[index].location,
                    openingHours: pickupInfo[index].openingHours,
                    shippingFee: 3000,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
