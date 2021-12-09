class ImageCardModel {
  String imageLink;
  String caption;
  ImageCardModel({this.imageLink, this.caption});

  //Method to return a list of sets containing index and item
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];

    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
