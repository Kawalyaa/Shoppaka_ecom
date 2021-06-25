import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/db/databse_services.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/pages/adress_book.dart';
import 'package:ecommerce_app/pages/favorites_page.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/order_list_page.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants.dart';

class NavigationDrawer extends StatefulWidget {
  final String name;
  final List address;
  final String email;
  final String photo;
  final List userInfo;
  NavigationDrawer(
      {this.name, this.address, this.photo, this.email, this.userInfo});

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  UserServices _userServices = UserServices();
  DatabaseServices _services = DatabaseServices();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    UserProv authState = Provider.of<UserProv>(context);

    return _auth.currentUser == null
        ? Drawer(
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Login.id);
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: kColorRed),
                ),
              ),
            ),
          )
        : StreamBuilder<QuerySnapshot>(
            stream:
                users.where('id', isEqualTo: _auth.currentUser.uid).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Something went wrong',
                    style: TextStyle(color: kColorRed),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Text("Loading....",
                        style: TextStyle(color: kColorRed)));
              }
              List snapData = snapshot.data.docs
                  .map((DocumentSnapshot snap) =>
                      UserModel.fromSnapShot(snap.data()))
                  .toList();

              return snapData.isEmpty
                  ? Container(
                      child: Center(
                          child: Text('No user Data',
                              style: TextStyle(
                                  color: kColorRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0))),
                    )
                  : Drawer(
                      child: ListView(
                        children: <Widget>[
                          //Header
                          UserAccountsDrawerHeader(
                            accountName: Text(snapData[0].name),
                            accountEmail: Text(snapData[0].email),
                            currentAccountPicture: GestureDetector(
                              onTap: () async {
                                await _userServices.uploadImage();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: snapData[0].photo == ''
                                    ? Container(
                                        color: Color(0xFF5A0031),
                                        child: Center(
                                          child: Text(
                                            snapData[0].name[0],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'images/loading_gif/Spin-1s-200px.gif'),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        imageUrl: snapData[0].photo,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                              ),
                            ),
                          ),

                          //Body
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, HomePage.id);
                            },
                            child: ListTile(
                              title: Text('Home Page'),
                              leading: Icon(Icons.home),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, AddressBook.id);
                            },
                            child: ListTile(
                              title: Text('My Address'),
                              leading: Icon(Icons.location_on),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, OrderList.id);
                            },
                            child: ListTile(
                              leading: Icon(Icons.shopping_basket),
                              title: Text('My Orders'),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShoppingCart(),
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.shopping_cart),
                              title: Text('Shopping Cart'),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Favorites.id);
                            },
                            child: ListTile(
                              leading: Icon(Icons.favorite),
                              title: Text('Favourites'),
                            ),
                          ),
                          Divider(),

                          InkWell(
                            onTap: () {
                              authState.signOut();
                              Navigator.pushReplacementNamed(context, Login.id);
                            },
                            child: ListTile(
                              leading: Icon(Icons.logout),
                              title: Text('Log Out'),
                            ),
                          )
                        ],
                      ),
                    );
            },
          );
  }
}
