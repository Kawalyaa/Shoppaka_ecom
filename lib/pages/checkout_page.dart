import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/componants/shipment_details.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/db/databse_services.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/pages/payment_successfull.dart';
import 'package:ecommerce_app/pages/pickup_station.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:ecommerce_app/services/orders_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'adress_book.dart';
import 'mobile_money_payment.dart';

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

  //int initialPrice = 3264;
  int shippingFee = 5000;
  int extraFee = 1000;
  int shippingFee2 = 0;
  double totalPrice;
  int index = 0;
  var result;
  var addressDetails;
  bool isDebug = false;
  List<UserModel> _userInfo;
  var cartData;

  OrdersServices _ordersServices = OrdersServices();
  DatabaseServices _databaseServices = DatabaseServices();

  var _response;
  List _cartListData;
  List addressList;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    _controller.addListener(handleTabSelection);
    final Checkout args = ModalRoute.of(context).settings.arguments;

    //_userInfo = Provider.of<List<UserModel>>(context, listen: true);
    //addressList = _userInfo[0].address;

    cartData = Provider.of<ProductProvider2>(context);
    List<CartModel> _cartList = cartData.cartProductList;
    _cartListData = _cartList;

    //_userInfo = Provider.of<List<UserModel>>(context);

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

            addressList = snapData[0].address;

            return TabBarView(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _deliveryInfoList(
                    subtotal: args.productPrice, addressList: addressList),
                _paymentInfoList(args.productPrice),
                _summeryInfoTab(
                    subtotal: args.productPrice,
                    addressList: addressList,
                    cartList: _cartList),
              ],
            );
          }),
    );
  }

  //################# Delivery Information ##############################

  Widget _deliveryInfoList({double subtotal, List addressList}) {
    totalPrice = selectedButton == Button.BUTTON1
        ? subtotal + shippingFee + extraFee
        : selectedButton == Button.BUTTON2
            ? subtotal + shippingFee
            : subtotal;
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
              TextButton(
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
            child: addressList == null || addressList.isEmpty
                ? Center(
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: kColorRed)),
                      child: TextButton(
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
                    ),
                  )

                ///Get address manual provided from pop()
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

                    ///Provide address automatically if available
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
                    'Express Shipping',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _text(
                      text:
                          'Delivered today on ${_returnDate(DateTime.now())} if ordered before 4pm'),
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
                    'Standard Shipping',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _text(
                      text:
                          'Delivered between ${_returnDate(DateTime.now().add(Duration(days: 1)))} and ${_returnDate(DateTime.now().add(Duration(days: 3)))}'),
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
                              'Available between ${_returnDate(DateTime.now().add(Duration(days: 1)))} and ${_returnDate(DateTime.now().add(Duration(days: 3)))}'),
                    ],
                  ),
                ),
              ),

              ///######********Return Pickup Station from Pickup Station Page only if selected #####

              result != null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 22.0, 8.0, 12.0),
                      child: Container(
                        height: 312.0,
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
                              child: TextButton(
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
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedButton = Button.BUTTON3;
                          });
                          _navigateToPickupStation(context);
                          // print(result[0].placeName);
                        },
                        // textColor: kColorRed,
                        child: Text(
                          'SELECT A PICKUP STATION',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kColorRed),
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
                    trailingTxt: selectedButton == Button.BUTTON3
                        ? 'UGX$shippingFee2'
                        : selectedButton == Button.BUTTON1
                            ? 'UGX${shippingFee + extraFee}'
                            : 'UGX$shippingFee',
                    textColor:
                        selectedButton == Button.BUTTON3 ? Colors.green : null),
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
                          if (selectedButton == Button.BUTTON3 &&
                                  result == null ||
                              addressList.isEmpty) {
                            showAlertDialog(context, 'Error',
                                'No Pickup Station Selected\nOr Address is missing');
                          } else {
                            setState(() {
                              index = 1;
                            });
                            _controller.animateTo(1);
                          }
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
                //crossAxisAlignment: CrossAxisAlignment.baseline,
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
                        leadingTxt: 'Shipping',
                        trailingTxt: selectedButton == Button.BUTTON3
                            ? 'UGX$shippingFee2'
                            : selectedButton == Button.BUTTON1
                                ? 'UGX${shippingFee + 1000}'
                                : 'UGX$shippingFee',
                        textColor: selectedButton == Button.BUTTON3
                            ? Colors.green
                            : null),
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

  _summeryInfoTab({double subtotal, List addressList, List cartList}) {
    return ListView(
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
                      leadingTxt: 'Shipping',
                      trailingTxt: selectedButton == Button.BUTTON3
                          ? 'UGX$shippingFee2'
                          : selectedButton == Button.BUTTON1
                              ? 'UGX${shippingFee + 1000}'
                              : 'UGX$shippingFee',
                      textColor: selectedButton == Button.BUTTON3
                          ? Colors.green
                          : null),
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
              TextButton(
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
                  //if no address provided
                  addressList == null || addressList.isEmpty
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: kColorRed)),
                            child: TextButton(
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
                          ),
                        )

                      ///Get address manual provided from pop()
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

                          ///Get address automatically
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
              TextButton(
                onPressed: () {
                  setState(() {
                    index = 0;
                    _controller.animateTo(0);
                  });
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
                    selectedButton == Button.BUTTON1
                        ? 'Express Shipping'
                        : selectedButton == Button.BUTTON2
                            ? 'Standard Shipping'
                            : 'PickupStation',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _text(
                    text: selectedButton == Button.BUTTON1
                        ? 'Delivered today ${_returnDate(DateTime.now())} if ordered before 4pm'
                        : selectedButton == Button.BUTTON3
                            ? 'Ready for pickup between ${_returnDate(DateTime.now().add(Duration(days: 1)))}  and ${_returnDate(DateTime.now().add(Duration(days: 3)))}'
                            : 'Delivered between ${_returnDate(DateTime.now().add(Duration(days: 1)))}  and ${_returnDate(DateTime.now().add(Duration(days: 3)))}',
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
                children: List.generate(
                  cartList.length,
                  (index) => ShipmentDetails(
                    index: index,
                    packageNumber: cartList.length,
                    itemNumber: cartList[index].qty,
                    itemDetails: cartList[index].name,
                    deliveryDate: selectedButton == Button.BUTTON1
                        ? 'Delivered today ${_returnDate(DateTime.now())} if ordered before 4pm'
                        : selectedButton == Button.BUTTON3
                            ? 'Ready for pickup between ${_returnDate(DateTime.now().add(Duration(days: 1)))}  and ${_returnDate(DateTime.now().add(Duration(days: 3)))}'
                            : 'Delivered between ${_returnDate(DateTime.now().add(Duration(days: 1)))}  and ${_returnDate(DateTime.now().add(Duration(days: 3)))}',
                  ),
                ),
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
              TextButton(
                onPressed: () {
                  setState(() {
                    index = 1;
                    _controller.animateTo(1);
                  });
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: _text(
                  text: payMethod == Pay.MobileMoney
                      ? 'Mobile Money-AIRTEL / MTN'
                      : 'Pay On Delivery',
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
            onPressed: () {
              if (payMethod == Pay.MobileMoney) {
                ///Go to mobile money page
                Navigator.pushNamed(context, MobileMoneyPay.id,
                    arguments: MobileMoneyPay(
                      orderedProducts: orderedItemsList(),
                      totalAmount: totalPrice,
                      pickupStation: result,
                    ));
              } else {
                ///Add orders to the fire
                _ordersServices
                    .createOrders(
                        userName: _userInfo[0].name,
                        email: _userInfo[0].email,
                        phone: addressList[0]['phone'],
                        addressList: addressList,
                        ordersList: orderedItemsList(),
                        paymentStatus: _response,
                        totalPrice: totalPrice,
                        paymentMethod: "CashOnDelivery",
                        pickupStation:
                            result != null ? pickUpStationList() : null,
                        context: context)
                    .then((value) => value == true
                        ? Navigator.pushReplacementNamed(
                            context, PaymentSuccessful.id)
                        : showAlertDialog(context, 'Message', 'upload error'));

                cartData.removeAllCartProducts();

                //Navigator.pushReplacementNamed(context, PaymentSuccessful.id);
              }
            },
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text('CONFIRM'),
          ),
        )
      ],
    );
  }

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

  String _returnDate(DateTime dateTime) => DateFormat.MMMEd().format(dateTime);

  _navigateToAddressBook(BuildContext context) async {
    addressDetails = await Navigator.pushNamed(context, AddressBook.id);
  }

  List orderedItemsList() => _cartListData
      .map((item) => {
            'image': item.images[0],
            'name': item.name,
            'qty': item.qty,
            'price': item.price,
            'selectedSize': item.selectedSize,
            'selectedColor': item.selectedColor,
          })
      .toList();

  List pickUpStationList() => result
      .map((station) => {
            'placeName': result[0].placeName,
            'location': result[0].location,
          })
      .toList();
}
