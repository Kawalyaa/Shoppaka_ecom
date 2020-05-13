import 'package:flutter/material.dart';
import '../constants.dart';

enum Options { ALL, SHOES, MEN, WOMEN, BLAZERS, JEWELRY, FEATURED }

class SelectCategory extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  final bool isSelected;
  final Function onSelected;

  SelectCategory({
    this.imageLocation,
    this.imageCaption,
    this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: InkWell(
        onTap: onSelected,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              border: Border.all(
                color: isSelected ? kColorRed : Colors.grey,
                width: isSelected ? 2.0 : 1.0,
              ),
              color: Colors.white),
          child: Row(
            children: <Widget>[
              imageLocation != null ? Image.asset(imageLocation) : SizedBox(),
              SizedBox(
                width: 3.0,
              ),
              Container(
                child: Text(
                  imageCaption,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Widget categoryOptDetail({
//  Function onSelected,
//  String imageLocation,
//  String imageCaption,
//  bool isSelected,
//}) {
//  return Container(
//    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//    child: InkWell(
//      onTap: onSelected,
//      child: Container(
//        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
//        alignment: Alignment.center,
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.all(
//              Radius.circular(20.0),
//            ),
//            border: Border.all(
//              color: isSelected ? kColorRed : Colors.grey,
//              width: isSelected ? 2.0 : 1.0,
//            ),
//            boxShadow: <BoxShadow>[
//              BoxShadow(
//                color: isSelected ? Color(0xfffbf2ef) : Colors.white,
//                offset: Offset(5.0, 5.0),
//                blurRadius: 10.0,
//                spreadRadius: 5.0,
//              )
//            ]),
//        child: Row(
//          children: <Widget>[
//            imageLocation != null ? Image.asset(imageLocation) : SizedBox(),
//            SizedBox(
//              width: 3.0,
//            ),
//            Container(
//              child: Text(
//                imageCaption,
//                style: TextStyle(
//                  fontWeight: FontWeight.w700,
//                  fontSize: 15.0,
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    ),
//  );
//}
