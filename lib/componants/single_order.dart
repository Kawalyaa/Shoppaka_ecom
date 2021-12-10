import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class SingleOrder extends StatelessWidget {
  final List orderList;
  final String orderNumber;
  final String orderStatus;
  final deliveryDate;
  final double totalPrice;
  final orderedTime;
  SingleOrder(
      {this.orderList,
      this.orderNumber,
      this.orderStatus,
      this.deliveryDate,
      this.orderedTime,
      this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 2.0,
        //color: Colors.white70,
        child: Column(
          children: [
            Card(
              elevation: 0,
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
                              child: FadeInImage.assetNetwork(
                                  alignment: Alignment.center,
                                  image: orderList[index]['image'],
                                  placeholder:
                                      'images/img_place_holder/placeholder-image.png',
                                  imageErrorBuilder: (context, url, error) =>
                                      Icon(
                                        Icons.error,
                                      )),
                            ),
                            SizedBox(
                              width: 14.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(orderList[index]['name']),
                                Text(
                                  'qty: ${orderList[index]['qty'].toString()}',
                                ),
                                Text(
                                  'color: ${orderList[index]['selectedColor']}',
                                ),
                                Text(
                                    'on: ${DateFormat('yyyy-MM-dd hh:mm').format(orderedTime.toDate())}'),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
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
                  Card(
                    child: Container(
                      padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      decoration: BoxDecoration(
                          color: orderStatus == 'delivered'
                              ? Colors.green[900]
                              : orderStatus == 'sorting'
                                  ? Colors.brown[900]
                                  : orderStatus == 'dispatched'
                                      ? Colors.amber[900]
                                      : orderStatus == 'arrived'
                                          ? Colors.green[600]
                                          : kColorRed,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          orderStatus,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  deliveryDate == ''
                      ? Container()
                      : Text(
                          '${DateFormat.yMd().format(deliveryDate.toDate())}'),
                  Text('UGX$totalPrice'),
                  Text(
                    '# $orderNumber',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
