import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserServices {
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _collections = 'users';
  void createUser(
      {String id, String name, String email, String photo, List address}) {
    FirebaseFirestore.instance.collection(_collections).doc(id).set({
      "id": id,
      "name": name,
      "email": email,
      "photo": photo,
      "address": address
    });
  }

  void updateUserData(Map<String, dynamic> values, String userId) async {
    FirebaseFirestore.instance
        .collection(_collections)
        .doc(userId)
        .update(values);
  }

  void updateUserAddress(Map<String, dynamic> values, String userId) async {
    await FirebaseFirestore.instance
        .collection(_collections)
        .doc(userId)
        .update({
      "address": FieldValue.arrayUnion([values])
    });
  }

  Future<bool> editAddress(Map values) async {
    User _user = _auth.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection(_collections)
          .doc(_user.uid)
          .update({
        "address": [values]
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> editAddress2(Map values) async {
    User _user = _auth.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection(_collections)
          .doc(_user.uid)
          .update({
        "address2": [values]
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void addDeviceToken(String token, String userId) => FirebaseFirestore.instance
      .collection(_collections)
      .doc(userId)
      .update({"token": token});

  Future<String> uploadUserPhoto(File image, String userId) async {
    Reference ref = storage.child("images/$userId.png");
    UploadTask task = ref.putFile(image);
    var downloadUrl = await task.whenComplete(() => ref.getDownloadURL());
    return downloadUrl.toString();
  }

  Future uploadImage() async {
    User user = _auth.currentUser;
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    File pickedImage = File(image.path);
    if (pickedImage != null) {
      Reference ref = storage.child("images/${user.uid}.png");
      UploadTask task = ref.putFile(pickedImage);
      await task.whenComplete(() => ref.getDownloadURL().then((photoUrl) {
            // imageUrl = photoUrl;
            FirebaseFirestore.instance
                .collection(_collections)
                .doc(user.uid)
                .update({"photo": photoUrl});
          }));
    }
  }
}
