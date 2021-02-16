class PickupLocationModel {
  static const REGION = 'region';
  static const PLACENAME = 'placeName';
  static const LOCATION = 'locaton';
  static const OPENINGHOURS = 'openingHours';
  static const SHIPPINGFEE = 'shippingFee';

  final String region;
  final String placeName;
  final String location;
  final String openingHours;
  final int shippingFee;

  PickupLocationModel(
      {this.placeName,
      this.location,
      this.openingHours,
      this.shippingFee,
      this.region});

  factory PickupLocationModel.fromMap(Map data) => PickupLocationModel(
      placeName: data[PLACENAME] ?? '',
      location: data[LOCATION] ?? '',
      openingHours: data[OPENINGHOURS] ?? '',
      region: data[REGION] ?? '',
      shippingFee: data[SHIPPINGFEE] ?? '');
}
