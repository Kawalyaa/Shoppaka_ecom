import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserServices {
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String collections = 'users';
  void createUser(
      {String id,
      String name,
      String email,
      String phone,
      String photo,
      String delivery}) {
    FirebaseFirestore.instance.collection(collections).doc(id).set({
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "photo": photo,
      "delivery": delivery
    });
  }

  void updateUserData(Map<String, dynamic> values, String userId) async {
    FirebaseFirestore.instance
        .collection(collections)
        .doc(userId)
        .update(values);
  }

  void addDeviceToken(String token, String userId) => FirebaseFirestore.instance
      .collection(collections)
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
                .collection(collections)
                .doc(user.uid)
                .update({"photo": photoUrl});
          }));
    }
  }
}
