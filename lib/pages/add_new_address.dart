import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AddNewAddress extends StatefulWidget {
  static const String id = 'AddNewAddress';

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _addressFormKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _contryCodeController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  List<String> _countryCodes = ['+256', '+1'];
  List<String> _region = [
    'Central',
    'Eastern',
    'Western',
    'Northern',
  ];
  List<String> _centralTowns = [
    'Kampala',
    'Kawempe',
    'Makindye',
    'Wandegeya',
    'Kololo'
  ];
  List<String> _westernTowns = [
    'Mbarara',
    'Bwizibwere',
    'Rukungiri',
    'Kabale',
    'Kisolo'
  ];

  var _selectedRegion;

  String _selectedTown;

  String _selectedCountryCode = '+1';
  UserServices _userServices = UserServices();

  bool isChecked = false;

  String _firstUserName;
  String _lastUserName;

  @override
  Widget build(BuildContext context) {
    List<UserModel> _userInfo = Provider.of<List<UserModel>>(context);

    List userName = _userInfo[0].name.split(" ");
    _firstUserName = userName[0];
    _lastUserName = userName[1];
    print(_firstUserName);

    List<String> _townFilter() {
      switch (_selectedRegion) {
        case 'Central':
          return _centralTowns;
          break;
        case 'Western':
          return _westernTowns;
          break;
      }
      //Return a list to a void null error
      return ['Central'];
    }

    var countryDropdown = Container(
      width: 50,
      child: DropdownButtonFormField(
        items: _countryCodes
            .map(
              (value) => DropdownMenuItem<String>(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 12.0),
                ),
                value: value,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedCountryCode = value;
          });
        },
        value: _selectedCountryCode,
      ),
    );
    var countryDropdown1 = Container(
      width: 50,
      child: DropdownButtonFormField(
        hint: Text(
          'Region',
          style: TextStyle(color: Colors.black),
        ),
        items: _region
            .map(
              (value) => DropdownMenuItem<String>(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 12.0),
                ),
                value: value,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedRegion = value;
          });
        },
        value: _selectedRegion,
      ),
    );
    var countryDropdown2 = Container(
      width: 50,
      child: DropdownButtonFormField(
        hint: Text(
          'District/Town/Area',
          style: TextStyle(color: Colors.black),
        ),
        items: _townFilter()
            .map(
              (value) => DropdownMenuItem<String>(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 12.0),
                ),
                value: value,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedTown = value;
          });
        },
        value: _selectedTown,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Address book',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('ADDRESS DETAILS'), Text('* Required')],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: Container(
                      // margin: EdgeInsets.only(left: 2, right: 20),
                      child: TextFormField(
                        controller: _firstNameController..text = _firstUserName,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ('Value Can\'t Be Empty');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'First Name',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 20.0, bottom: 5.0, right: 2.0),
                            child: Text(
                              '*',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: Container(
                      // margin: EdgeInsets.only(left: 2, right: 20),
                      child: TextFormField(
                        controller: _lastNameController..text = _lastUserName,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ('Value Can\'t Be Empty');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Last Name',

                          hintText: 'Last Name',
                          // icon: Icon(Icons.star),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 20.0, bottom: 5.0, right: 2.0),
                            child: Text(
                              '*',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: Container(
                      child: TextFormField(
                        controller: _addressController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ('Value Can\'t Be Empty');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Adress',
                          hintText: 'Adress',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 20.0, bottom: 5.0, right: 2.0),
                            child: Text(
                              '*',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 11,
                            child: Container(child: countryDropdown1)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            '*',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 11,
                            child: Container(child: countryDropdown2)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            '*',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Container(child: countryDropdown)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            // margin: EdgeInsets.only(left: 2, right: 20),
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return ('Value Can\'t Be Empty');
                                } else if (value.length != 10) {
                                  return ('Invalide phone number');
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Mobile Phone Number',
                                hintText: 'Mobile Phone Number',
                                //prefix: countryDropdown,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      top: 20.0,
                                      bottom: 5.0,
                                      right: 2.0),
                                  child: Text(
                                    '*',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: kColorRed,
                          checkColor: Colors.white,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                              //TODO Update the address list where default equal to true turn to false
                              //  if(isChecked==true)
                            });
                          },
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Default Shipping Address',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
            child: MaterialButton(
              height: 45.0,
              minWidth: double.infinity,
              color: kColorRed,
              onPressed: () {
                User _user = _auth.currentUser;

                if (_addressFormKey.currentState.validate() &&
                    _selectedRegion != null &&
                    _selectedTown != null) {
                  showProgress(context, 'Saving...', false);

                  try {
                    _userServices.updateUserAddress({
                      'name':
                          _firstNameController.text + _lastNameController.text,
                      'address': _addressController.text,
                      'region': _selectedRegion,
                      'town': _selectedTown,
                      'phone': _selectedCountryCode + _phoneController.text,
                      'default': isChecked
                    }, _user.uid);
                    hideProgress();
                  } catch (e) {
                    hideProgress();
                    showAlertDialog(context, "Error", e.toString());

                    print(e);
                    return e;
                  }
                }
              },
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('SAVE'),
            ),
          )
        ],
      ),
    );
  }
}

//Padding(
//padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
//child: Container(
//// margin: EdgeInsets.only(left: 2, right: 20),
//child: TextField(
//decoration: InputDecoration(
//hintText: 'District/Town/Area',
//// icon: Icon(Icons.star),
//suffixIcon: Padding(
//padding: const EdgeInsets.only(
//left: 20.0, top: 20.0, bottom: 5.0, right: 2.0),
//child: Row(
//children: [
//Text(
//'*',
//style: TextStyle(fontSize: 18),
//),
//],
//),
//),
//),
//),
//),
//),
