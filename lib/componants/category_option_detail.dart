import 'package:flutter/material.dart';
import '../constants.dart';

enum Options { ALL, HIGH_END, SHOES, MEN, WOMEN, JEWELRY, FEATURED, SORTED }

class SelectCategory extends StatelessWidget {
  final String imageLocation;
  final String caption;
  final bool isSelected;
  final Function onSelected;

  SelectCategory({
    this.imageLocation,
    this.caption,
    this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
              imageLocation != null
                  ? Container(
                      height: 80,
                      width: 45,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imageLocation),
                            fit: BoxFit.cover),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: 3.0,
              ),
              Container(
                child: caption != null
                    ? Text(
                        caption,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                        ),
                      )
                    : SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
