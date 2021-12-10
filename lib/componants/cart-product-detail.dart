import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecommerce_app/constants.dart';

class CartItems extends StatelessWidget {
  final int id;
  final String name;
  final String picture;
  final double price;
  final String selectedColor;
  final String selectedSize;
  final Function buttonUp;
  final Function buttonDown;
  final Function deleteItem;
  final int quantity;

  CartItems(
      {this.id,
      this.name,
      this.quantity,
      this.picture,
      this.selectedColor,
      this.price,
      this.selectedSize,
      this.buttonUp,
      this.buttonDown,
      this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(picture,
                width: 80.0,
                height: 80.0,
                errorBuilder: (context, url, error) => Icon(
                      Icons.error,
                    )),
            SizedBox(
              width: 20.0,
            ),

            Container(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$name',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  //******Size section******
                  selectedSize == 'No Size'
                      ? Container()
                      : RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: 'Size :'),
                              TextSpan(
                                text: '$selectedSize',
                                style: TextStyle(color: kColorRed),
                              ),
                            ],
                          ),
                        ),

                  SizedBox(
                    height: 5.0,
                  ),

                  //*****Color section*******
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Color : '),
                        TextSpan(
                          text: '$selectedColor',
                          style: TextStyle(color: kColorRed),
                        ),
                      ],
                    ),
                  ),
                  //******Price Section******
                  Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      'UGX$price',
                      style: TextStyle(
                          color: kColorRed,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 15.0,
            ),

            //*******Icon Button section*****
            Column(
              children: <Widget>[
                IconButton(
                  onPressed: buttonUp,
                  icon: Icon(Icons.arrow_drop_up),
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                IconButton(
                  onPressed: buttonDown,
                  icon: Icon(Icons.arrow_drop_down),
                )
              ],
            ),
            SizedBox(
              width: 15.0,
            ),
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: deleteItem,
                    child: Icon(
                      Icons.delete,
                      size: 25.0,
                      color: kColorRed,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
