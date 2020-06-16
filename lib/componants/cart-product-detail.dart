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
  int quantity;

  CartItems(
      {this.id,
      this.name,
      this.picture,
      this.selectedColor,
      this.price,
      this.selectedSize,
      this.quantity,
      this.buttonUp,
      this.buttonDown,
      this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              picture,
              width: 80.0,
              height: 80.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    //******Size section******
                    Text('Size :'),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '$selectedSize',
                        style: TextStyle(color: kColorRed),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),

                    //*****Color section*******
                    Text('Color :'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$selectedColor',
                        style: TextStyle(color: kColorRed),
                      ),
                    ),
                  ],
                ),

                //******Price Section******
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    '\$$price',
                    style: TextStyle(
                        color: kColorRed,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
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
              //color: Colors.cyan,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
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
