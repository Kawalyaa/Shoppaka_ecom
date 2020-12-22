import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

import '../constants.dart';

enum Button { BUTTON1, BUTTON2 }

class Checkout extends StatefulWidget {
  static const String id = 'checkout';

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Button selectedButton;
  int shippingFee = 7000;
  int index = 0;

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
              buttons: selectedButton,
              callBack: () {
                setState(() {
                  selectedButton = Button.BUTTON1;
                });
              },
              callBack2: () {
                setState(() {
                  selectedButton = Button.BUTTON2;
                });
              }),
          _deliveryInfoList(),
          _deliveryInfoList()
        ],
      ),
    );
  }

  Widget _deliveryInfoList(
      {var buttons, Function callBack, Function callBack2}) {
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
                onPressed: () {},
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kawalya Andrew',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _text(
                  'Kampala',
                ),
                SizedBox(
                  height: 5.0,
                ),
                _text(
                  'Kampala Region',
                ),
                SizedBox(
                  height: 5.0,
                ),
                _text(
                  'Central Business District',
                ),
                SizedBox(
                  height: 5.0,
                ),
                _text(
                  '0793231021',
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
        InkWell(
          onTap: callBack,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 20.0, bottom: 15.0),
              child: ListTile(
                leading: buttons == Button.BUTTON1
                    ? _selectedRing()
                    : _unSelectedRing(),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starndard Shipping',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _text('Delivered between Tuesday 5 Jan and Tuesday 12 Jan'),
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
                                  color: kColorRed,
                                  fontWeight: FontWeight.bold)),
                        ])),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: callBack2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 20.0, bottom: 15.0),
              child: ListTile(
                leading: buttons == Button.BUTTON2
                    ? _selectedRing()
                    : _unSelectedRing(),
                subtitle: Column(
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
                      'Available between Tuesday Jan and Tuesday 12 Jan with Cheaper Local Delivery Fees',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 65.0,
              right: 65.0,
            ),
            child: FlatButton(
              onPressed: () {},
              textColor: kColorRed,
              child: Text(
                'SELECT A PICKUP STATION',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              _costsTile(
                  leadingTxt: 'Subtotal',
                  trailingTxt: 'UGX 3264',
                  textColor: Colors.black),
              _costsTile(leadingTxt: 'Shipping', trailingTxt: 'UGX 7000'),
              _costsTile(
                  leadingTxt: 'International Customs Fee',
                  trailingTxt: 'UGX 29126'),
              Divider(
                thickness: 2.0,
              ),
              _costsTile(leadingTxt: 'Total', trailingTxt: 'UGX 39,390'),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: kColorRed,
                      borderRadius: BorderRadius.circular(5.0),
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
              )
            ],
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

  _text(String text) => Text(
        text,
        style: TextStyle(color: Colors.black45),
      );

  _selectedRing() => Container(
        padding: EdgeInsets.all(3.0),
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: kColorRed,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          //foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          radius: 4.0,
          child: Icon(
            Icons.circle,
            size: 16,
            color: kColorRed,
          ),
        ),
      );

  _unSelectedRing() => Container(
        padding: EdgeInsets.all(3.0),
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          //foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          radius: 4.0,
        ),
      );
}
