import 'package:ecommerce_app/pages/splash_screen.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import './pages/login_options_page.dart';
import './pages/login.dart';
import './pages/home_page.dart';
import './pages/product_details.dart';
import './pages/shopping_cart_screen.dart';
import './pages/signup.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';

import 'componants/screen_controller.dart';
import 'db/databse_services.dart';
import 'model/product2.dart';
import 'package:ecommerce_app/provider/product_provider2.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider.initialize(),
          ),
          StreamProvider<List<Products2>>(
              create: (_) => DatabaseServices().getAllFireStoreProduct()),
          ChangeNotifierProvider<ProductProvider2>(
            create: (_) => ProductProvider2(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //initialRoute: ScreenController.id,
          routes: {
            Login.id: (context) => Login(),
            SignUp.id: (context) => SignUp(),
            HomePage.id: (context) => HomePage(),
            ProductDetails.id: (context) => ProductDetails(),
            ShoppingCart.id: (context) => ShoppingCart(),
            WelcomeLoginOptions.id: (context) => WelcomeLoginOptions(),
          },
          theme: ThemeData(primaryColor: Color(0xFFFF0025)),
          home: ScreenController(),
        ),
      );
}
