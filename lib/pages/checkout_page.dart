import 'dart:ui';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/pages/pickup_station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'adress_book.dart';

enum Button { BUTTON1, BUTTON2, BUTTON3 }
enum Pay { MobileMoney, OnDelivery }

class Checkout extends StatefulWidget {
  static const String id = 'checkout';

  final double productPrice;
  final String productName;
  final String size;
  final String quantity;
  final String color;
  final int shippingFee;
  Checkout(
      {this.productPrice,
      this.productName,
      this.size,
      this.shippingFee,
      this.quantity,
      this.color});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Button selectedButton = Button.BUTTON1;
  Pay payMethod = Pay.MobileMoney;
  int initialPrice = 3264;
  int shippingFee = 7000;
  int shippingFee2 = 0;
  double totalPrice;
  int index = 0;
  var result;
  var addressDetails;

  @override
  void initState() {
    _controller = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleTabSelection() {
    _controller.index = index;
  }

  final List<Tab> _tabs = <Tab>[
    Tab(
      child: Container(
        height: 20.0,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Delivery',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Payment',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Summery',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _controller.addListener(handleTabSelection);
    final Checkout args = ModalRoute.of(context).settings.arguments;

    List<UserModel> _userInfo = Provider.of<List<UserModel>>(context);
    List addressList = _userInfo[0].address;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black45),
        ),
        iconTheme: IconThemeData(color: Colors.black45),
        elevation: 1,
        bottom: TabBar(
          onTap: (index) {
            index = null;
          },
          controller: _controller,
          unselectedLabelColor: Colors.black45,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: kColorRed,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _deliveryInfoList(
              subtotal: args.productPrice, addressList: addressList),
          _paymentInfoList(args.productPrice),
          _summeryInfoTab(
              subtotal: args.productPrice, addressList: addressList),
        ],
      ),
    );
  }

  //################# Delivery Information ##############################

  Widget _deliveryInfoList({double subtotal, List addressList}) {
    totalPrice =
        selectedButton == Button.BUTTON1 ? subtotal + shippingFee : subtotal;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ADDRESS DETAILS',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              FlatButton(
                onPressed: () {
                  _navigateToAddressBook(context);
                },
                child: Text(
                  'CHANGE',
                  style:
                      TextStyle(color: kColorRed, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 20.0, bottom: 15.0),

            ///Check if user has added address or selected address from address list
            child: addressList == null
                ? Center(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddressBook.id);
                      },
                      child: Text(
                        'Add Address',
                        style: TextStyle(
                            color: kColorRed,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : addressDetails != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addressDetails[0].name,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          _text(
                            text: addressDetails[0].town,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _text(
                            text: addressDetails[0].region,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _text(
                            text: addressDetails[0].address,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _text(
                            text: addressDetails[0].phone,
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addressList[0]['name'],
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          _text(
                            text: addressList[0]['town'],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _text(
                            text: addressList[0]['region'],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _text(
                            text: addressList[0]['address'],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _text(
                            text: addressList[0]['phone'],
                          )
                        ],
                      ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0, top: 10.0),
          child: Text(
            'DELIVERY OPTIONS',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          ),
        ),
        Card(
          child: ListTile(
            leading: Radio(
              activeColor: kColorRed,
              groupValue: selectedButton,
              onChanged: (Button value) {
                setState(() {
                  selectedButton = value;
                });
              },
              value: Button.BUTTON1,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 22.0, bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Starndard Shipping',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _text(
                      text:
                          'Delivered between Tuesday 5 Jan and Tuesday 12 Jan'),
                  SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                          children: [
                        TextSpan(text: 'Shipping Fee'),
                        TextSpan(
                            text: ' UGX $shippingFee',
                            style: TextStyle(
                                color: kColorRed, fontWeight: FontWeight.bold)),
                      ])),
                ],
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Radio(
              activeColor: kColorRed,
              groupValue: selectedButton,
              onChanged: (Button value) {
                setState(() {
                  selectedButton = value;
                });
              },
              value: Button.BUTTON2,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 22.0, bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Express Shipping',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _text(
                      text:
                          'Delivered between Tuesday 5 Jan and Tuesday 12 Jan'),
                  SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                          children: [
                        TextSpan(text: 'Shipping Fee'),
                        TextSpan(
                            text: ' UGX $shippingFee',
                            style: TextStyle(
                                color: kColorRed, fontWeight: FontWeight.bold)),
                      ])),
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Radio(
                  activeColor: kColorRed,
                  groupValue: selectedButton,
                  value: Button.BUTTON3,
                  onChanged: (Button value) {
                    setState(() {
                      selectedButton = value;
                    });
                  },
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 22.0, bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup Station',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _text(
                        text:
                            'Available between Tuesday Jan and Tuesday 12 Jan with Cheaper Local Delivery Fees',
                      ),
                    ],
                  ),
                ),
              ),

              ///######********Return Pickup Station from Pickup Station Page only if selected #####

              result != null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 22.0, 8.0, 12.0),
                      child: Container(
                        height: 315.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 25.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    result[0].placeName,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text(
                                    result[0].location,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16.0),
                                  ),
                                  Text(
                                    'Opening Hours',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 18.0),
                                  ),
                                  Text(result[0].openingHours,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16.0)),
                                  Text(
                                    'Shipping Fee',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'UGX ${result[0].shippingFee}',
                                    style: TextStyle(
                                        color: kColorRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                            Center(
                              child: FlatButton(
                                child: Text(
                                  'CHANGE PICKUP STATION',
                                  style: TextStyle(color: kColorRed),
                                ),
                                onPressed: () {
                                  _navigateToPickupStation(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
              result != null
                  ? Container()
                  : SizedBox(
                      child: Divider(
                        thickness: 2.0,
                      ),
                    ),
              result != null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 65.0,
                        right: 65.0,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          _navigateToPickupStation(context);
                          // print(result[0].placeName);
                        },
                        textColor: kColorRed,
                        child: Text(
                          'SELECT A PICKUP STATION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 15.0),
          child: Card(
            child: Column(
              children: [
                _costsTile(
                    leadingTxt: 'Subtotal',
                    trailingTxt: 'UGX $subtotal',
                    textColor: Colors.black),
                _costsTile(
                    leadingTxt: 'Shipping',
                    trailingTxt: selectedButton == Button.BUTTON1
                        ? 'UGX $shippingFee'
                        : 'UGX $shippingFee2',
                    textColor:
                        selectedButton == Button.BUTTON2 ? Colors.green : null),
                _costsTile(
                    leadingTxt: 'International Customs Fee',
                    trailingTxt: 'UGX 29126'),
                Divider(
                  thickness: 2.0,
                ),
                _costsTile(leadingTxt: 'Total', trailingTxt: 'UGX $totalPrice'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kColorRed,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 2.0,
                              blurRadius: 5.0,
                              offset: Offset(0, 1.0))
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                          _controller.animateTo(1);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                              'PROCEED TO PAYMENT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: 5.0, bottom: 12.0, top: 5.0, left: 2.0),
                  child: Text(
                    'You will be able to add a voucher in the next step',
                    style: TextStyle(fontSize: 16.0, color: Colors.black45),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

//################# Payment Information ##############################

  _paymentInfoList(double subtotal) => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 18.0, bottom: 10.0),
            child: Text(
              'SELECT A PAYMENT METHOD',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ),
          payMethod == Pay.OnDelivery
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                    child: ListTile(
                      leading: Radio(
                        activeColor: kColorRed,
                        groupValue: payMethod,
                        value: Pay.MobileMoney,
                        onChanged: (Pay value) {
                          setState(() {
                            payMethod = value;
                          });
                        },
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Money -Airtel/Mtn',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/mobile_money/airtel.png',
                                  height: 50,
                                  width: 50,
                                ),
                                Image.asset('images/mobile_money/mtn.png',
                                    height: 33, width: 33)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                    child: ListTile(
                      leading: Radio(
                        activeColor: kColorRed,
                        groupValue: payMethod,
                        value: Pay.MobileMoney,
                        onChanged: (Pay value) {
                          setState(() {
                            payMethod = value;
                          });
                        },
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Money -Airtel/Mtn',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/mobile_money/airtel.png',
                                  height: 50,
                                  width: 50,
                                ),
                                Image.asset('images/mobile_money/mtn.png',
                                    height: 33, width: 33)
                              ],
                            ),
                            Text(
                              'Go Cashless and Stay Safe-Eligible for Contactless Safe Delivery \nPlease ensure you have enough funds on your mobile money wallet to make payment instantly to avoid order cancellation \n \n How to pay;\n1  Confirm your order\n2  You\'ll be redirected to the payment payment page\n3  Select your operator(service provider)\n4  Enter your mobile money number\n5  Click pay now\n6  Check your phone for payment request\n7  Enter your MoMo PIN\n8  Approve payment to Shopla\n9  You will recieve SMS/Email confirmation message for a seccessful payment\n\nYour payment is safe.If anything goes wrong,we\'ve got your back',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            child: Card(
              child: ListTile(
                leading: Radio(
                  activeColor: kColorRed,
                  groupValue: payMethod,
                  value: Pay.OnDelivery,
                  onChanged: (Pay value) {
                    setState(() {
                      payMethod = value;
                    });
                  },
                ),
                title: Text(
                  'Cash On Delivery',
                  style: TextStyle(color: Colors.black54, fontSize: 18.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 8.0, 8.0, 8.0),
            child: Text(
              'USE YOUR VOUCHER',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 80.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Container(
                    height: 50.0,
                    width: 230.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      decoration: kVoucherInputDecoration,
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    color: kColorRed,
                    height: 48.0,
                    minWidth: 20.0,
                    textColor: Colors.white,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Text('APPLY'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _costsTile(
                        leadingTxt: 'Subtotal',
                        trailingTxt: 'UGX$subtotal',
                        textColor: Colors.black),
                    _costsTile(
                        leadingTxt: 'Shipping', trailingTxt: 'UGX$shippingFee'),
                    _costsTile(
                        leadingTxt: 'Internation Customs Fee',
                        trailingTxt: 'UGX 29126'),
                    SizedBox(
                      child: Divider(
                        thickness: 2.0,
                      ),
                    ),
                    _costsTile(
                        leadingTxt: 'Total', trailingTxt: 'UGX$totalPrice'),
                    MaterialButton(
                      height: 45.0,
                      minWidth: double.infinity,
                      color: kColorRed,
                      onPressed: () {
                        setState(() {
                          index = 2;
                          _controller.animateTo(2);
                        });
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('PROCEED TO SUMMERY'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  //################# Summery Information ##############################

  _summeryInfoTab({double subtotal, addressList}) => ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 25.0, bottom: 10.0),
            child: Text(
              'YOUR ORDER',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Material(
            elevation: 1,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _costsTile(
                        leadingTxt: 'Subtotal',
                        trailingTxt: 'UGX$subtotal',
                        textColor: Colors.black),
                    _costsTile(
                        leadingTxt: 'Shipping', trailingTxt: 'UGX$shippingFee'),
                    _costsTile(
                        leadingTxt: 'Internation Customs Fee',
                        trailingTxt: 'UGX 29126'),
                    SizedBox(
                      child: Divider(
                        thickness: 1.0,
                      ),
                    ),
                    _costsTile(
                        leadingTxt: 'Total', trailingTxt: 'UGX$totalPrice'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'YOUR ADDRESS',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'CHANGE',
                    style: TextStyle(
                        color: kColorRed, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Material(
            elevation: 1,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addressList == null
                        ? Center(
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AddressBook.id);
                              },
                              child: Text(
                                'Add Address',
                                style: TextStyle(
                                    color: kColorRed,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : addressDetails != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addressDetails[0].name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  _text(
                                    text: addressDetails[0].town,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  _text(
                                    text: addressDetails[0].region,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  _text(
                                    text: addressDetails[0].address,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  _text(
                                    text: addressDetails[0].phone,
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addressList[0]['name'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  _text(
                                    text: addressList[0]['town'],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  _text(
                                    text: addressList[0]['region'],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  _text(
                                    text: addressList[0]['address'],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  _text(
                                    text: addressList[0]['phone'],
                                  )
                                ],
                              ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DELIVERY METHOD',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'CHANGE',
                    style: TextStyle(
                        color: kColorRed, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.0, 10, 8.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard Shipping',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _text(
                      text: 'Delivered between Friday 22 and Tuesday 16 Feb',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 15.0),
            child: Text(
              'SHIPMENT DETAILS',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _text(text: 'PACKAGE 1 OF 2', fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        _text(text: '1 x', fontWeight: FontWeight.bold),
                        SizedBox(
                          width: 20,
                        ),
                        _text(text: 'Mini Pillow Speaker-White', fontSize: 16)
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    _text(
                        text:
                            'Fulfilled by:Allwinshop88 \nDelivered between 10 Feb and Wednesday 17 Feb'),
                    SizedBox(
                      child: Divider(
                        thickness: 1.0,
                      ),
                    ),
                    _text(text: 'PACKAGE 2 OF 2', fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        _text(text: '1 x', fontWeight: FontWeight.bold),
                        SizedBox(
                          width: 20,
                        ),
                        _text(text: 'Orange Soda-2 Liters', fontSize: 16)
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    _text(
                        text:
                            'Fulfilled by:Shopla \nDelivered between Saturday 23 Jan and Tuesday 26 Jan'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PAYMENT METHOD',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'CHANGE',
                    style: TextStyle(
                        color: kColorRed, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: _text(
                    text: 'Mobile Money-AIRTEL / MTN',
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              height: 45.0,
              minWidth: double.infinity,
              color: kColorRed,
              onPressed: () {},
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('CONFIRM'),
            ),
          )
        ],
      );

  ListTile _costsTile({String leadingTxt, trailingTxt, Color textColor}) =>
      ListTile(
        leading: Text(leadingTxt,
            style: TextStyle(color: Colors.black, fontSize: 18)),
        trailing: Text(trailingTxt,
            style: TextStyle(
                color: textColor ?? kColorRed,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      );

  _text({String text, var fontWeight, double fontSize, var color}) => Text(
        text,
        style: TextStyle(
            color: color ?? Colors.black45,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontSize: fontSize ?? 14.0),
      );

  _navigateToPickupStation(BuildContext context) async {
    result = await Navigator.pushNamed(context, PickupStation.id);
  }

  _navigateToAddressBook(BuildContext context) async {
    addressDetails = await Navigator.pushNamed(context, AddressBook.id);
  }
}
