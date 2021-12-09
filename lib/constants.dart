import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color kColorRed = Color(0xFFFF0025);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0))),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
  ),
);

const kVoucherInputDecoration = InputDecoration(
  hintText: 'Your Voucher',
  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 2.0),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8.0),
      bottomLeft: Radius.circular(8.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8.0),
      bottomLeft: Radius.circular(8.0),
    ),
  ),
);
