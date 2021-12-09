import 'package:ecommerce_app/pages/favorites_page.dart';
import 'package:ecommerce_app/pages/prod_detail.dart';
import 'package:ecommerce_app/provider/app_state_provider.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:ecommerce_app/provider/users_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './pages/login_options_page.dart';
import './pages/login.dart';
import './pages/home_page.dart';
import './pages/shopping_cart_screen.dart';
import './pages/signup.dart';
import './pages/checkout_page.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';

import 'componants/screen_controller.dart';
import 'db/databse_services.dart';
import 'model/product2.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';

main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          //ChangeNotifierProvider<UserProvider>(
          // create: (_) => UserProvider.initialize(),
          //),
          ChangeNotifierProvider<UserProv>(
            create: (_) => UserProv(),
          ),
          StreamProvider<List<Products2>>(
            create: (_) => DatabaseServices().getAllFireStoreProduct(),
          ),
          ChangeNotifierProvider<ProductProvider2>(
            create: (_) => ProductProvider2(),
          ),
          ChangeNotifierProvider<FavoriteList>(
            create: (_) => FavoriteList(),
          )
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
          },
          theme: ThemeData(primaryColor: Color(0xFFFF0025)),
          home: ScreenController(),
        ),
      );
}
