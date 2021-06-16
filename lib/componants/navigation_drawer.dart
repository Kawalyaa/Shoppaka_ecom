import 'package:ecommerce_app/pages/favorites_page.dart';
import 'package:ecommerce_app/pages/order_list_page.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/shopping_cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NavigationDrawer extends StatefulWidget {
  final String name;
  final List address;
  final String email;
  final String photo;
  NavigationDrawer({this.name, this.address, this.photo, this.email});

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    UserProv authState = Provider.of<UserProv>(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          //Header
          UserAccountsDrawerHeader(
            accountName: Text(widget.name ?? ''),
            accountEmail: Text(widget.email ?? ''),
            currentAccountPicture: GestureDetector(
              onTap: () async {
                await _userServices.uploadImage();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: widget.photo == ''
                    ? Container(
                        color: Color(0xFF5A0031),
                        child: Center(
                          child: Text(
                            widget.name[0],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'images/loading_gif/Spin-1s-200px.gif'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        imageUrl: widget.photo,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
            ),
          )
        ],
      ),
    );
  }
}

// FadeInImage.assetNetwork(
// fit: BoxFit.cover,
// placeholder: 'images/loading_gif/Spin-1s-200px.gif',
// image: widget.photo),
