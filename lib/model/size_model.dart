class SizeModel {
  bool isSelected = false;

  String sizeName;

  SizeModel({this.sizeName});

  factory SizeModel.fromList(String name) {
    //This function is not used though it works
    return SizeModel(sizeName: name ?? '');
  }
}
