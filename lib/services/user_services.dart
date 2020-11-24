import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/users.dart';

class UserServices {
  String collections = 'users';
  void createUser(
      {String id,
      String name,
      String email,
      String phone,
      String photo = 'No photo',
      String delivery = 'Not set'}) {
    FirebaseFirestore.instance.collection(collections).doc(id).set({
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "photo": photo,
      "delivery": delivery
    });
  }

  void updateUserData(Map<String, dynamic> values) {
    FirebaseFirestore.instance
        .collection(collections)
        .doc(values['id'])
        .update(values);
  }

  Future<UserModel> getUserById(String id) => FirebaseFirestore.instance
      .collection(collections)
      .doc(id)
      .get()
      .then((doc) => UserModel.fromSnapshot(doc));

  void addDeviceToken(String token, String userId) => FirebaseFirestore.instance
      .collection(collections)
      .doc(userId)
      .update({"token": token});
}
