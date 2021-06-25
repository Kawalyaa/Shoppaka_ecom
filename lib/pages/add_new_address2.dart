import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AddAddress2 extends StatefulWidget {
  static const String id = 'addAddress2';
  @override
  _AddAddress2State createState() => _AddAddress2State();
}

class _AddAddress2State extends State<AddAddress2> {
  final _addressFormKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  List<String> _countryCodes = ['+1', '+256'];
  List<String> _region = [
    'Central',
    'Western',
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
    'Bwizibwera',
    'Rukungiri',
    'Kabale',
    'Kisolo'
  ];

  var _selectedRegion;

  String _selectedTown;

  String _selectedCountryCode = '+256';
  UserServices _userServices = UserServices();

  bool isChecked = false;

  String _firstUserName;
  String _lastUserName;

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
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
      return ['error'];
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
    var regionDropdown = Container(
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
            _selectedTown = null;
            _selectedRegion = value;
          });
        },
        value: _selectedRegion,
      ),
    );
    var townDropdown = Container(
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
          'Add Second Address ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              _users.where('id', isEqualTo: _auth.currentUser.uid).snapshots(),
          builder: (context, snapshot) {
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
                  child:
                      Text("Loading....", style: TextStyle(color: kColorRed)));
            }
            List snapData = snapshot.data.docs
                .map((DocumentSnapshot snap) =>
                    UserModel.fromSnapShot(snap.data()))
                .toList();

            List userName = snapData[0].name.split(" ");
            _firstUserName = userName[0];
            _lastUserName = userName.length == 1 ? "null" : userName[1];

            return ListView(
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
                              controller: _firstNameController
                                ..text = _firstUserName,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return ('Value Can\'t Be Empty');
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: kUnderLineBorder,
                                labelText: 'First Name',
                                hintText: 'First Name',
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                          child: Container(
                            // margin: EdgeInsets.only(left: 2, right: 20),
                            child: TextFormField(
                              controller: _lastNameController
                                ..text = _lastUserName,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return ('Value Can\'t Be Empty');
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: kUnderLineBorder,
                                labelText: 'Last Name',

                                hintText: 'Last Name',
                                // icon: Icon(Icons.star),
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
                                focusedBorder: kUnderLineBorder,
                                labelText: 'Address',
                                hintText: 'Address',
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 11,
                                  child: Container(child: regionDropdown)),
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
                                  child: Container(child: townDropdown)),
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
                                  child: Container(child: countryDropdown)),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return ('Value Can\'t Be Empty');
                                      } else if (value.length > 10) {
                                        return ('Invalid phone number');
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: kUnderLineBorder,
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
                                  });
                                },
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Default Shipping Address',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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
                    onPressed: () async {
                      if (_addressFormKey.currentState.validate() &&
                          _selectedRegion != null &&
                          _selectedTown != null) {
                        showProgress(context, 'Saving...', false);
                        if (!await _userServices.editAddress2({
                          'name': _firstNameController.text +
                              ' ' +
                              _lastNameController.text,
                          'address': _addressController.text,
                          'region': _selectedRegion,
                          'town': _selectedTown,
                          'phone': _selectedCountryCode +
                              _phoneController.text
                                  .replaceFirst(RegExp(r'^0+'), ''),
                          'default': isChecked
                        })) {
                          hideProgress();
                          showAlertDialog(context, "Error", "SignUp Failed");
                        } else {
                          hideProgress();
                          Navigator.pop(context);
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
            );
          }),
    );
  }
}
