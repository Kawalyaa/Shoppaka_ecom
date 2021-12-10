import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/pages/payment_successfull.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:ecommerce_app/services/orders_services.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

enum ServiceProvider { AIRTEL, MTN }

class MobileMoneyPay extends StatefulWidget {
  final double totalAmount;
  final List orderedProducts;
  final pickupStation;

  MobileMoneyPay({this.orderedProducts, this.totalAmount, this.pickupStation});

  static const String id = 'mobileMoneyPay';

  @override
  _MobileMoneyPayState createState() => _MobileMoneyPayState();
}

class _MobileMoneyPayState extends State<MobileMoneyPay> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _airtelPhoneController = TextEditingController();
  TextEditingController _mtnPhoneController = TextEditingController();
  OrdersServices _ordersServices = OrdersServices();

  ServiceProvider _serviceProvider = ServiceProvider.AIRTEL;

  bool isDebug = true;
  // MobileMoneyPay _args;
  List<UserModel> _userInfo;
  String _ugCurrency = FlutterwaveCurrency.UGX;
  var _response;
  var _cartData;

  @override
  Widget build(BuildContext context) {
    //args = ModalRoute.of(context).settings.arguments;
    _userInfo = Provider.of<List<UserModel>>(context);
    //_args = ModalRoute.of(context).settings.arguments as MobileMoneyPay;

    _cartData = Provider.of<ProductProvider2>(context);

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
              child: RadioListTile(
                groupValue: _serviceProvider,
                activeColor: kColorRed,
                onChanged: (value) {
                  setState(() {
                    _serviceProvider = value;
                  });
                },
                value: ServiceProvider.AIRTEL,
                title: Row(
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
                ? Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                    child: TextFormField(
                      validator: (value) =>
                          value.isNotEmpty ? null : "phone number is required",
                      keyboardType: TextInputType.phone,
                      controller: _airtelPhoneController,
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
              height: 5.0,
            ),
            Card(
              child: RadioListTile(
                groupValue: _serviceProvider,
                activeColor: kColorRed,
                onChanged: (value) {
                  setState(() {
                    _serviceProvider = value;
                  });
                },
                value: ServiceProvider.MTN,
                title: Row(
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
            SizedBox(
              height: 5.0,
            ),
            _serviceProvider == ServiceProvider.MTN
                ? Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                    child: TextFormField(
                      validator: (value) =>
                          value.isNotEmpty ? null : "Phone number is required",
                      keyboardType: TextInputType.phone,
                      controller: _mtnPhoneController,
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
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black54, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                height: 45.0,
                minWidth: double.infinity,
                color: kColorRed,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    if (_serviceProvider == ServiceProvider.AIRTEL ||
                        _serviceProvider == ServiceProvider.MTN) {
                      _handelPaymentInitialization();

                      _cartData.removeAllCartProducts();
                      _airtelPhoneController.clear();
                      _mtnPhoneController.clear();
                    }
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

  _handelPaymentInitialization2() async {
    final flutterWave = Flutterwave.forUIPayment(
      acceptUSSDPayment: true,
      fullName: _userInfo[0].name,
      email: _userInfo[0].email,
      txRef: DateTime.now().toIso8601String(),
      phoneNumber: _mtnPhoneController.text.trim(),
      isDebugMode: isDebug,
      currency: _ugCurrency,
      context: context,
      amount: widget.totalAmount.toString(),
      acceptUgandaPayment: true,
      publicKey: 'FLWPUBK_TEST-8c05487cc28d9fe8f34f08eb46589ed6-X',
      encryptionKey: 'FLWSECK_TESTb4725f3c6e15',
    );

    final response = await flutterWave.initializeForUiPayments();
    response != null
        ? showAlertDialog(context, 'Msg', response.data.status)
        : showAlertDialog(context, 'Msg', 'No Response');
  }

  _handelPaymentInitialization() async {
    final flutterWave = Flutterwave.forUIPayment(
        acceptUSSDPayment: true,
        fullName: _userInfo[0].name,
        email: _userInfo[0].email,
        txRef: DateTime.now().toIso8601String(),
        phoneNumber: _serviceProvider == ServiceProvider.AIRTEL
            ? _airtelPhoneController.text.trim()
            : _mtnPhoneController.text.trim(),
        isDebugMode: false,
        currency: _ugCurrency,
        context: context,
        amount: "500",
        acceptUgandaPayment: true,
        publicKey: 'FLWPUBK-515fba68c059b487d73e3368c46fc35f-X',
        encryptionKey: '45742576d0de5608b5801d26',
        narration: 'Shopla');

    _response = await flutterWave.initializeForUiPayments();
    print(
        '/////////\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ ${_response.data.status}');

    if (_response.data.status == "successful") {
      ///send payment details to the admin
      _ordersServices.createOrders(
          userName: _userInfo[0].name,
          email: _userInfo[0].email,
          phone: _userInfo[0].phone,
          ordersList: widget.orderedProducts,
          paymentStatus: _response.data.status,
          totalPrice: widget.totalAmount,
          paymentMethod: "MobileMoney",
          pickupStation:
              widget.pickupStation != null ? _pickUpStationList() : null,
          context: context);

      Navigator.pushReplacementNamed(context, PaymentSuccessful.id);
    } else {
      showAlertDialog(context, 'Message', _response.data.status);
    }
  }

  List _pickUpStationList() => widget.pickupStation
      .map((station) => {
            'placeName': widget.pickupStation[0].placeName,
            'location': widget.pickupStation[0].location,
          })
      .toList();
}
