import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

enum ServiceProvider { AIRTEL, MTN }

class MobileMoneyPay extends StatefulWidget {
  final String totalAmount;
  final List orderedProducts;

  MobileMoneyPay({this.orderedProducts, this.totalAmount});

  static const String id = 'mobileMoneyPay';

  @override
  _MobileMoneyPayState createState() => _MobileMoneyPayState();
}

class _MobileMoneyPayState extends State<MobileMoneyPay> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  ServiceProvider _serviceProvider = ServiceProvider.AIRTEL;

  bool isDebug = true;
  MobileMoneyPay _args;
  List<UserModel> _userInfo;
  String _ugCurrency = FlutterwaveCurrency.UGX;

  @override
  Widget build(BuildContext context) {
    //args = ModalRoute.of(context).settings.arguments;
    _userInfo = Provider.of<List<UserModel>>(context);
    _args = ModalRoute.of(context).settings.arguments as MobileMoneyPay;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          elevation: 0.0,
          title: Text(
            'Select Service Provider',
            style: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: formKey,
          child: Column(children: [
            Card(
              child: ListTile(
                leading: Radio(
                  groupValue: _serviceProvider,
                  activeColor: kColorRed,
                  onChanged: (value) {
                    setState(() {
                      _serviceProvider = value;
                    });
                  },
                  value: ServiceProvider.AIRTEL,
                ),
                subtitle: Row(
                  children: [
                    Image.asset(
                      'images/mobile_money/airtel.png',
                      width: 60.0,
                      height: 60.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Airtel Money',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            _serviceProvider == ServiceProvider.AIRTEL
                ? Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TextFormField(
                      validator: (value) =>
                          value.isNotEmpty ? null : "phone number is required",
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      decoration: kVoucherInputDecoration.copyWith(
                        hintText: 'Airtel Number',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 15.0,
            ),
            Card(
              child: ListTile(
                leading: Radio(
                  groupValue: _serviceProvider,
                  activeColor: kColorRed,
                  onChanged: (value) {
                    setState(() {
                      _serviceProvider = value;
                    });
                  },
                  value: ServiceProvider.MTN,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/mobile_money/mtn.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'MTN MoMo',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            _serviceProvider == ServiceProvider.MTN
                ? Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TextFormField(
                      validator: (value) =>
                          value.isNotEmpty ? null : "Phone number is required",
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      decoration: kVoucherInputDecoration.copyWith(
                        hintText: 'MTN Number',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                height: 45.0,
                minWidth: double.infinity,
                color: kColorRed,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    _phoneController.clear();
                    _handelPaymentInitialization();
                    print(_userInfo[0].email);

                    ///send payment details to the admin
                  }
                },
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('PAY'),
              ),
            )
          ]),
        ));
  }

  _handelPaymentInitialization() async {
    final flutterWave = Flutterwave.forUIPayment(
      acceptUSSDPayment: true,
      fullName: _userInfo[0].name,
      email: _userInfo[0].email,
      txRef: DateTime.now().toIso8601String(),
      phoneNumber: _phoneController.text.trim(),
      isDebugMode: isDebug,
      currency: _ugCurrency,
      context: context,
      amount: _args.totalAmount,
      acceptUgandaPayment: true,
      publicKey: 'FLWPUBK_TEST-8c05487cc28d9fe8f34f08eb46589ed6-X',
      encryptionKey: 'FLWSECK_TESTb4725f3c6e15',
    );

    final response = await flutterWave.initializeForUiPayments();
    response != null
        ? showAlertDialog(context, 'Msg', response.data.status)
        : showAlertDialog(context, 'Msg', 'No Response');
  }
}
