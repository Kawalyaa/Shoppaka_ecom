import 'package:ecommerce_app/componants/product_image_slider.dart';
import 'package:ecommerce_app/componants/single_similar_product.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/model/color_model.dart';
import 'package:ecommerce_app/model/favorites_model.dart';
import 'package:ecommerce_app/model/product_details_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/model/size_model.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class ProdDetails extends StatefulWidget {
  static const String id = 'productDetails';
  final ProductDetailsModel productDetailsModel;

  ProdDetails({this.productDetailsModel});

  @override
  _ProdDetailsState createState() => _ProdDetailsState();
}

class _ProdDetailsState extends State<ProdDetails> {
  int currentSelectedSizeIndex;
  int currentSelectedColorIndex;

  List<SizeModel> sizeList;
  List<ColorModel> colorList;

  String selectedSize;
  String selectedColor;

  List<ProductsModel> similarProdList;
  bool descHeight = false;

  //bool isFavorite;
  var _controller = ScrollController();
  var physics;

  @override
  void initState() {
    super.initState();
    populateSizeListData();
    populateColorListData();
  }

  populateSizeListData() {
    sizeList = <SizeModel>[];
    //converting widget.productSizes into SizeModel to resolve onTap issues
    widget.productDetailsModel.productSizes
        .map((item) => sizeList.add(SizeModel(sizeName: item)))
        .toList();
  }

//==Convert a list of string colors['red','blue']
//== to list<ColorModel> of colors [Colors.red,Colors.blue]
  populateColorListData() {
    colorList = <ColorModel>[];

    widget.productDetailsModel.productColors.map((item) {
      switch (item) {
        case 'red':
          colorList.add(ColorModel(colorName: kColorRed));
          break;
        case 'white':
          colorList.add(ColorModel(colorName: Colors.white));
          break;
        case 'black':
          colorList.add(ColorModel(colorName: Colors.black));
          break;
        case 'brown':
          colorList.add(ColorModel(colorName: Colors.brown));
          break;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProductProvider2>(context);
    List<CartModel> cartList = providerData.cartProductList;
    var favData = Provider.of<FavoritesProvider>(context);

    List<ProductsModel> similarProdList =
        widget.productDetailsModel.similarProd;

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        physics = const NeverScrollableScrollPhysics();
      }
    });

    //========Create a List method that get products depending on the category======

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    'images/logos/shopla6.png',
                    fit: BoxFit.cover,
                  )),
              Text(
                'Shopla',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                    fontSize: 22.0,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ShoppingCart.id);
            },
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 4.0,
                right: 2.0,
                child: cartList.length > 0
                    ? Container(
                        height: 18.0,
                        width: 18.0,
                        decoration: BoxDecoration(
                            color: kColorRed, shape: BoxShape.circle),
                        child: Center(child: Text('${cartList.length}')),
                      )
                    : Container(),
              )
            ]),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: widget.productDetailsModel.heroTag,
            child: ProductImageSlider(
              imageList: widget.productDetailsModel.productDetailsPicture,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.productDetailsModel.productDetailsName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'UGX ${widget.productDetailsModel.productDetailsOldPrice}',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'UGX${widget.productDetailsModel.productDetailsPrice}',
                  style: TextStyle(
                      color: kColorRed,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900),
                ),
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
                  child: SizedBox(
                    height: 42,
                    child: Material(
                      elevation: 2.0,
                      color: kColorRed,
                      borderRadius: BorderRadius.circular(15.0),
                      child: MaterialButton(
                        minWidth: 140.0,
                        //height: 42.0,
                        onPressed: () {
                          providerData.addProducts(
                            CartModel(
                              images: widget
                                  .productDetailsModel.productDetailsPicture,
                              name:
                                  widget.productDetailsModel.productDetailsName,
                              brand: widget.productDetailsModel.productBrand,
                              price: widget
                                  .productDetailsModel.productDetailsPrice,
                              selectedSize: selectedSize == null &&
                                      widget.productDetailsModel.productSizes
                                          .isEmpty
                                  ? 'No Size'
                                  : selectedSize == null
                                      ? widget
                                          .productDetailsModel.productSizes[0]
                                      : selectedSize,
                              selectedColor: selectedColor == null &&
                                      widget.productDetailsModel.productColors
                                          .isEmpty
                                  ? widget.productDetailsModel.color
                                  : selectedColor == null
                                      ? widget
                                          .productDetailsModel.productColors[0]
                                      : selectedColor,
                            ),
                          );
                        },
                        elevation: 0.2,
                        child: Text(
                          'Add To Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.0,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.productDetailsModel.isFavorite =
                          !widget.productDetailsModel.isFavorite;

                      widget.productDetailsModel.isFavorite
                          ? favData.addToFavorite(FavoritesModel(
                              name:
                                  widget.productDetailsModel.productDetailsName,
                              images: widget
                                  .productDetailsModel.productDetailsPicture,
                              price: widget
                                  .productDetailsModel.productDetailsPrice,
                              oldPrice: widget
                                  .productDetailsModel.productDetailsOldPrice,
                              favorite: widget.productDetailsModel.isFavorite,
                              brand: widget.productDetailsModel.productBrand,
                              category: widget.productDetailsModel.category,
                              selectedSize:
                                  widget.productDetailsModel.productSizes,
                              selectedColor:
                                  widget.productDetailsModel.productColors))
                          : favData.removeFavName(
                              widget.productDetailsModel.productDetailsName);
                    });
                  },
                  child: Icon(
                    widget.productDetailsModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: kColorRed,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),

          //=========size section========
          SizedBox(
            height: 15.0,
          ),
          widget.productDetailsModel.productSizes.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, top: 5.0, bottom: 15.0),
                        child: Text(
                          'Available Sizes',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
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
                  child: colorList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                              widget.productDetailsModel.productColors[0],
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: colorList.length,
                          itemBuilder: (context, int index) => _colorCard(
                              color: colorList[index].colorName,
                              isSelected: currentSelectedColorIndex == index,
                              toggleIsSelected: () {
                                setState(() {
                                  currentSelectedColorIndex = index;
                                  if (colorList[index].colorName == kColorRed) {
                                    selectedColor = 'red';
                                  }
                                  if (colorList[index].colorName ==
                                      Colors.black) {
                                    selectedColor = 'black';
                                  }
                                  if (colorList[index].colorName ==
                                      Colors.white) {
                                    selectedColor = 'white';
                                  }
                                  if (colorList[index].colorName ==
                                      Colors.brown) {
                                    selectedColor = 'brown';
                                  } else {
                                    selectedColor = widget
                                        .productDetailsModel.productColors[0];
                                  }
                                });
                              })),
                ),
              ],
            ),
          ),

          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 2.0),
            child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      onTap: () {
                        setState(() {
                          descHeight = !descHeight;
                        });
                      },
                      leading: Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      trailing: !descHeight
                          ? Text(
                              'More',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.5),
                            )
                          : Text(
                              'Less',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.5),
                            ),
                    ),
                  ),
                  Divider(),
                  !descHeight
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 60.0,
                          width: double.infinity,
                          child: widget.productDetailsModel.description.isEmpty
                              ? Container()
                              : ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: _description()),
                        )
                      : widget.productDetailsModel.keyFeatures.isEmpty
                          ? Container()
                          : Card(
                              elevation: 0,
                              // height: 400,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        elevation: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: _description(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        'Key Features',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Card(
                                        elevation: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: _keyFeatures(),
                                        ),
                                      ),
                                    ]),
                              ),
                            )
                ],
              ),
            ),
          ),

          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: _specs(
                  text1: 'Brand',
                  text2: widget.productDetailsModel.productBrand,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: _specs(
                    text1: 'Name',
                    text2: widget.productDetailsModel.productDetailsName),
              ),
              widget.productDetailsModel.color == ''
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                      child: _specs(
                          text1: 'Color',
                          text2: selectedColor == null
                              ? widget.productDetailsModel.productColors[0]
                              : selectedColor),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                      child: _specs(
                          text1: 'Color',
                          text2: widget.productDetailsModel.color),
                    ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: _specs(text1: 'Condition', text2: 'New'),
              ),
            ],
          ),

          //******SIMILAR PRODUCTS*******
          Divider(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Similar Products',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.only(bottom: 20),
            child: similarProdList == null
                ? Container()
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: similarProdList.length,
                    itemBuilder: (context, int index) => SimilarSingleProduct(
                          name: similarProdList[index].name,
                          images: similarProdList[index].images,
                          price: similarProdList[index].price,
                          oldPrice: similarProdList[index].oldPrice,
                          brand: similarProdList[index].brand,
                          colors: similarProdList[index].colors,
                          sizes: similarProdList[index].sizes,
                          color: similarProdList[index].color,
                          description: similarProdList[index].description,
                          keyFeatures: similarProdList[index].keyFeatures,
                          similarProduct: similarProdList,
                          isFavorite: similarProdList[index].favorite,
                          toggleFavorite: () {
                            setState(() {
                              //===toggle favorite=====
                              similarProdList[index].favorite =
                                  !similarProdList[index].favorite;

                              //===Add or Remove  Favorite======
                              similarProdList[index].favorite
                                  ? favData.addToFavorite(FavoritesModel(
                                      name: similarProdList[index].name,
                                      images: similarProdList[index].images,
                                      price: similarProdList[index].price,
                                      oldPrice: similarProdList[index].oldPrice,
                                      brand: similarProdList[index].brand,
                                      category: similarProdList[index].category,
                                      color: similarProdList[index].color,
                                      description:
                                          similarProdList[index].description,
                                      keyFeatures:
                                          similarProdList[index].keyFeatures,
                                      selectedColor:
                                          similarProdList[index].colors,
                                      selectedSize:
                                          similarProdList[index].sizes,
                                      favorite:
                                          similarProdList[index].favorite))
                                  : favData.removeFavorite(index);
                            });
                          },
                        )),
          ),
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
            color: isSelected ? kColorRed : Colors.white,
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

  List<Widget> _description() =>
      widget.productDetailsModel.description.map((item) => Text(item)).toList();
  List<Widget> _keyFeatures() => widget.productDetailsModel.keyFeatures
      .map((item) => Text('--$item'))
      .toList();

  Widget _specs({String text1, String text2}) => RichText(
          text: TextSpan(style: TextStyle(color: Colors.black), children: [
        TextSpan(text: "$text1: "),
        TextSpan(text: text2, style: TextStyle(color: Colors.black54))
      ]));
}
