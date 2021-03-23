import 'package:flutter/material.dart';

import '../constants.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  SearchField({@required this.focusNode, @required this.textEditingController});
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black45)),
              Expanded(
                child: TextField(
                  autofocus: true,
                  cursorColor: kColorRed,
                  textAlign: TextAlign.center,
                  controller: textEditingController,
                  focusNode: focusNode,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Eg: iphone 11',
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.black45),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  textEditingController.clear();
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.black45,
                ),
              )
            ],
          ),
        ),
      );
}
