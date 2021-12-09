import 'package:ecommerce_app/model/product2.dart';
import 'package:flutter/material.dart';
import '../pages/prod_detail.dart';

class ShoesCategory extends StatefulWidget {
  @override
  _ShoesCategoryState createState() => _ShoesCategoryState();
}

class _ShoesCategoryState extends State<ShoesCategory> {
  @override
  Widget build(BuildContext context) {
    List<Products2> shoes = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shoes',
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: shoes.length,
        itemBuilder: (context, index) => ShoesItems(
          brand: shoes[index].brand,
          name: shoes[index].name,
          price: shoes[index].price,
        ),
      ),
    );
  }
}

class ShoesItems extends StatelessWidget {
  final String brand;
  final String name;
  final List picture;
  final List size;
  final double price;
  final double oldPrice;
  final List color;
  ShoesItems(
      {this.name,
      this.picture,
      this.size,
      this.color,
      this.price,
      this.brand,
      this.oldPrice});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdDetails(
              productDetailsName: name,
              productBrand: brand,
              productDetailsPrice: price,
              productDetailsOldPrice: oldPrice,
              productDetailsPicture: picture,
            ),
          ),
        );
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              picture[0],
              width: 90.0,
              height: 90.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  brand,
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  '\$$price',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
