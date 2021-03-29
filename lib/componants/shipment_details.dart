import 'package:flutter/material.dart';

class ShipmentDetails extends StatelessWidget {
  final int packageNumber;
  final int index;
  final String itemDetails;
  final int itemNumber;
  final String deliveryDate;

  ShipmentDetails(
      {this.deliveryDate,
      this.index,
      this.itemDetails,
      this.packageNumber,
      this.itemNumber});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'PACKAGE ${index + 1} OF $packageNumber',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
          SizedBox(
            height: 15.0,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                    text: '$itemNumber x  ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: itemDetails),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            deliveryDate,
            style: TextStyle(color: Colors.black45, fontSize: 14.0),
          ),
          SizedBox(
            child: Divider(
              thickness: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
