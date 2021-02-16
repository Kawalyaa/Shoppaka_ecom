import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  List<Widget> _addressList = [];
  List<Widget> get addressList => _addressList;

  addNewAddress(
    String firstName,
    String lastName,
    String address,
    String additionalInfo,
    String region,
    String division,
    int phoneNumber,
    bool defaultAddress,
  ) {
    //_addressList.add();
  }
}
