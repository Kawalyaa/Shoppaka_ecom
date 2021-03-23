import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/pages/adress_book.dart';
import 'package:ecommerce_app/pages/category_products_list.dart';
import 'package:ecommerce_app/pages/favorites_page.dart';
import 'package:ecommerce_app/pages/pickup_station.dart';
import 'package:ecommerce_app/pages/prod_detail.dart';
import 'package:ecommerce_app/pages/search_page.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/login_options_page.dart';
import './pages/login.dart';
import './pages/home_page.dart';
import './pages/shopping_cart_screen.dart';
import './pages/signup.dart';
import './pages/checkout_page.dart';
import 'package:provider/provider.dart';

import 'componants/screen_controller.dart';
import 'db/databse_services.dart';
import 'model/product2.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';

import 'model/users.dart';
import 'pages/add_new_address.dart';

int initScreen;

Future<void> main() async {
  //Make app work only vertically
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProv>(
            create: (_) => UserProv(),
          ),
          StreamProvider<List<Products2>>(
            create: (_) => DatabaseServices().getAllFireStoreProduct(),
          ),
          StreamProvider<List<UserModel>>(
            create: (_) => DatabaseServices().getUserInfo(),
          ),
          ChangeNotifierProvider<ProductProvider2>(
            create: (_) => ProductProvider2(),
          ),
          ChangeNotifierProvider<FavoriteList>(
            create: (_) => FavoriteList(),
          ),
//
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //initialRoute: ScreenController.id,
          routes: {
            Login.id: (context) => Login(),
            SignUp.id: (context) => SignUp(),
            HomePage.id: (context) => HomePage(),
            ProdDetails.id: (context) => ProdDetails(),
            ShoppingCart.id: (context) => ShoppingCart(),
            WelcomeLoginOptions.id: (context) => WelcomeLoginOptions(),
            Favorites.id: (context) => Favorites(),
            Checkout.id: (context) => Checkout(),
            PickupStation.id: (context) => PickupStation(),
            AddressBook.id: (context) => AddressBook(),
            AddNewAddress.id: (context) => AddNewAddress(),
            CategoryProductsList.id: (context) => CategoryProductsList(),
            ProductSearch.id: (context) => ProductSearch()
          },
          theme: ThemeData(
              primaryColor: kColorRed, textSelectionHandleColor: kColorRed),
          home: initScreen == 0 || initScreen == null
              ? WelcomeLoginOptions()
              : ScreenController(),
        ),
      );
}
