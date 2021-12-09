//Using UserModel class as a type
class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONE = "phone";
  static const TOKEN = "token";
  static const PHOTO = 'photo';
  static const ADDRESS = 'address';
  static const ADDRESS2 = 'address2';

  final String name;
  final String email;
  final String id;
  final String photo;
  final String phone;
  final List address;
  final List address2;
  final String token;
  UserModel(
      {this.id,
      this.name,
      this.email,
      this.photo,
      this.phone,
      this.address,
      this.address2,
      this.token});

  //Constructor expecting data from a snapshot
  factory UserModel.fromSnapShot(Map data) {
    return UserModel(
        id: data[ID] ?? '',
        name: data[NAME] ?? '',
        email: data[EMAIL] ?? '',
        photo: data[PHOTO] ?? '',
        phone: data[PHONE] ?? '',
        address: data[ADDRESS] ?? [],
        address2: data[ADDRESS2] ?? [],
        token: data[TOKEN] ?? '');
  }
}
