import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/color_model.dart';
import 'package:ecommerce_app/model/size_model.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:provider/provider.dart';

class ProdDetails extends StatefulWidget {
  static const String id = 'productDetails';
  final productDetailsName;
  final List productDetailsPicture;
  final productDetailsPrice;
  final productDetailsOldPrice;
  final productBrand;
  final List productSizes;
  final List productColors;
  bool isFavorite;

  ProdDetails({
    this.productDetailsPicture,
    this.productDetailsName,
    this.productDetailsOldPrice,
    this.productDetailsPrice,
    this.productBrand,
    this.productSizes,
    this.productColors,
    this.isFavorite,
  });

  @override
  _ProdDetailsState createState() => _ProdDetailsState();
}

class _ProdDetailsState extends State<ProdDetails> {
  String selectedSize;
  String selectedColor;

  int currentSelectedSizeIndex;
  int currentSelectedColorIndex;

  List<SizeModel> sizeList;
  List<ColorModel> colorList;

  @override
  void initState() {
    super.initState();
    populateSizeListData();
    populateColorListData();
  }

  populateSizeListData() {
    sizeList = <SizeModel>[];
    //converting widget.productSizes into SizeModel to resolve onTap issues

    widget.productSizes
        .map((item) => sizeList.add(SizeModel(sizeName: item)))
        .toList();
  }

//==Convert a list of string colors['red','blue']
//== to list<ColorModel> of colors [Colors.red,Colors.blue]
  populateColorListData() {
    colorList = <ColorModel>[];

    widget.productColors.map((item) {
      if (item == 'red') {
        colorList.add(ColorModel(colorName: Colors.red));
      }
      if (item == 'white') {
        colorList.add(ColorModel(colorName: Colors.white));
      }
      if (item == 'black') {
        colorList.add(ColorModel(colorName: Colors.black));
      }
      if (item == 'brown') {
        colorList.add(ColorModel(colorName: Colors.brown));
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var addToCart = Provider.of<ProductProvider2>(context);
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              )),
          child: Text(
            'Shopla',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w900,
                fontFamily: 'Poppins',
                fontSize: 24.0,
                fontStyle: FontStyle.italic),
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: widget.productDetailsName,
            child: Container(
              height: 300.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(widget.productDetailsPicture[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
            child: Row(
              children: <Widget>[
                Text(
                  widget.productDetailsName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '\$${widget.productDetailsOldPrice}',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '\$${widget.productDetailsPrice}',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Material(
                    elevation: 2.0,
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      minWidth: 200.0,
                      height: 42.0,
                      onPressed: () {},
                      elevation: 0.2,
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                IconButton(
                  onPressed: () {
                    addToCart.addProducts(
                      CartModel(
                          images: widget.productDetailsPicture,
                          name: widget.productDetailsName,
                          brand: widget.productBrand,
                          price: widget.productDetailsPrice,
                          selectedSize: selectedSize,
                          selectedColor: selectedColor),
                    );
                  },
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.isFavorite = !widget.isFavorite;
                    });
                  },
                  child: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          //=========size section========
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 5.0, bottom: 15.0),
                  child: Text(
                    'Available Sizes',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),

                //index and   int currentSelectedIndex are used to make 1 selection at ago
                Container(
                  height: 50.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizeList.length,
                      itemBuilder: (context, int index) {
                        return _sizeCard(
                            aSize: sizeList[index].sizeName,
                            isSelected: currentSelectedSizeIndex == index,
                            toggleIsSelected: () {
                              setState(() {
                                currentSelectedSizeIndex = index;
                                selectedSize = sizeList[index].sizeName;
                              });
                            });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          //=======Color Options Section===========
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 5.0, bottom: 5.0),
                  child: Text(
                    'Colors',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Container(
                  height: 50.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colorList.length,
                      itemBuilder: (context, int index) => _colorCard(
                          color: colorList[index].colorName,
                          isSelected: currentSelectedColorIndex == index,
                          toggleIsSelected: () {
                            setState(() {
                              currentSelectedColorIndex = index;
                              if (colorList[index].colorName == Colors.red) {
                                selectedColor = 'red';
                              }
                              if (colorList[index].colorName == Colors.black) {
                                selectedColor = 'black';
                              }
                              if (colorList[index].colorName == Colors.white) {
                                selectedColor = 'white';
                              }
                              if (colorList[index].colorName == Colors.brown) {
                                selectedColor = 'browm';
                              }
                            });
                          })),
                ),
              ],
            ),
          ),

          Divider(),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            subtitle: Text(
                'The latest fasion trending in town.This fashion is fitting and classic for both the youth and elders,they are strong and with colors that can not be breached'),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Name',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.productDetailsName,
                    style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Brand',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('${widget.productBrand}',
                    style: TextStyle(color: Colors.black54)),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Condition',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  (5.0),
                ),
                child: Text('New', style: TextStyle(color: Colors.black54)),
              )
            ],
          ),
          //******SIMILAR PRODUCTS*******
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Similar Products'),
          ),
//          Container(
//            height: 360.0,
//            child: SimilarProducts(),
//          ),
        ],
      ),
    );
  }

  Widget _sizeCard({
    String aSize,
    bool isSelected,
    Function toggleIsSelected,
  }) {
    return InkWell(
      onTap: toggleIsSelected,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.grey,
              style: !isSelected ? BorderStyle.solid : BorderStyle.none,
            ),
            color: isSelected ? Colors.red : Colors.white,
          ),
          child: Center(
            child: Text(
              aSize,
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.black54),
            ),
          ),
        ),
      ),
    );
  }

  Widget _colorCard({Color color, bool isSelected, Function toggleIsSelected}) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: InkWell(
        onTap: toggleIsSelected,
        child: CircleAvatar(
          radius: 12.0,
          backgroundColor:
              color == Colors.white ? Colors.grey : color.withAlpha(150),
          child: isSelected
              ? Icon(
                  Icons.check_circle,
                  size: 18.0,
                  color: color,
                )
              : CircleAvatar(
                  radius: 7.0,
                  backgroundColor: color,
                ),
        ),
      ),
    );
  }
}
