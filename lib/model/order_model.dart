class OrderModel {
  static const ID = 'id';
  static const USER_NAME = 'userName';
  static const PHONE = 'phone';
  static const ORDER_LIST = 'ordersList';
  static const ORDER_NUMBER = 'orderNumber';
  static const TOTAL_PRICE = 'totalPrice';
  static const PICKUP_STATION = 'pickupStation';
  static const ORDER_STATUS = 'orderStatus';
  static const DELIVERY_DATE = 'deliveryDate';
  static const TIME = 'time';
  static const DELIVERY_METHOD = 'deliveryMethod';

  final List ordersList;
  final List pickupStation;
  final String orderStatus;
  final String orderNumber;
  final int totalPrice;
  final deliveryDate;
  final time;
  final String deliveryMethod;

  OrderModel(
      {this.totalPrice,
      this.orderNumber,
      this.ordersList,
      this.orderStatus,
      this.pickupStation,
      this.deliveryDate,
      this.time,
      this.deliveryMethod});

  factory OrderModel.fromSnapShot(Map data) => OrderModel(
        totalPrice: data[TOTAL_PRICE],
        orderNumber: data[ORDER_NUMBER] ?? '',
        ordersList: data[ORDER_LIST] ?? [],
        orderStatus: data[ORDER_STATUS] ?? '',
        pickupStation: data[PICKUP_STATION] ?? [],
        deliveryDate: data[DELIVERY_DATE] ?? '',
        time: data[TIME] ?? '',
        deliveryMethod: data[DELIVERY_METHOD] ?? '',
      );
}
