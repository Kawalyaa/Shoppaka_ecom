import 'package:ecommerce_app/pages/favorites_page.dart';
import 'package:ecommerce_app/pages/login_options_page.dart';
import 'package:ecommerce_app/provider/app_state_provider.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/db/users.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'dart:io';
import 'package:ecommerce_app/services/user_services.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  UserServices _userServices = UserServices();
  final ImagePicker _imagePicker = ImagePicker();
  String _userName;
  String _userEmail;
  File _image;
  String _photoLink;

  Future chooseImage() async {
    //await ImagePicker.pickImage(source: null)
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //UserServices _userServices = UserServices();
    UserProv authState = Provider.of<UserProv>(context);
    var userInfo = authState.userModel;
    //reload = authState.reloadUser();

    return Drawer(
      child: ListView(
        children: <Widget>[
          //Header
          UserAccountsDrawerHeader(
            accountName: Text(userInfo.name),
            accountEmail: Text(userInfo.email),
            currentAccountPicture: GestureDetector(
              onTap: () async {
                chooseImage();
                _photoLink =
                    await _userServices.uploadUserPhoto(_image, userInfo.id);
                authState.updateUserData({"photo": _photoLink});
              },
              child: CircleAvatar(
                backgroundColor: _photoLink == null ? Colors.grey : null,
                child: _photoLink != null
                    ? NetworkImage(_photoLink)
                    : Icon(Icons.person),
              ),
            ),
          ),

          //Body
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My Account'),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('My Oders'),
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
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.blue,
              ),
              title: Text('About'),
            ),
          ),
          InkWell(
              onTap: () {
                authState.signOut();
                Navigator.pushReplacementNamed(context, Login.id);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
