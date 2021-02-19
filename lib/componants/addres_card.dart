import 'package:ecommerce_app/pages/add_new_address.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AddressCard extends StatelessWidget {
  final String name;
  final String region;
  final String town;
  final String address;
  final String phone;
  final String defaultAddress;

  AddressCard(
      {this.name,
      this.region,
      this.town,
      this.address,
      this.phone,
      this.defaultAddress});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      FlatButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AddNewAddress.id),
                        child: Text(
                          'Edit',
                          style: TextStyle(color: kColorRed),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    region,
                    style: TextStyle(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    town,
                    style: TextStyle(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    address,
                    style: TextStyle(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    phone,
                    style: TextStyle(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    defaultAddress,
                    style: TextStyle(color: Colors.black45),
                  ),
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
    );
  }
}
