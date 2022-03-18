import 'dart:core';


class CallDataModel {
  late String id;
  late String userId;
  late String customerId;
  late DateTime setDateTime;
  late DateTime creationDateTime;
  late String status;
  late DateTime doDateTime;
  late int enable;
  late String comment;
  late String customerName;
  late String userName;
  late String customerMobile;
  late String hashTags;

  CallDataModel(
      {required this.id,
      required this.userId,
      required this.customerId,
      required this.setDateTime,
      required this.creationDateTime,
      required this.status,
      required this.doDateTime,
      required this.enable,
      required this.customerName,
      required this.userName,
      required this.customerMobile,
      required this.comment,
      required this.hashTags});

  void mapToCustomer(Map<String, dynamic> mapObject) {
    this.id = mapObject["id"];
    this.userId = mapObject["userId"];
    this.customerId = mapObject["customerId"];
    this.creationDateTime = mapObject["creationDateTime"];
    this.comment = mapObject["comment"];
    this.status = mapObject["status"];
    this.doDateTime = mapObject["doDateTime"];
    this.enable = mapObject["enable"];
    this.setDateTime = mapObject["setDateTime"];
    this.userName = mapObject["userName"];
    this.customerMobile = mapObject["enable"];
    this.customerName = mapObject["customerName"];
    this.hashTags = mapObject["hashTags"];

  }

  Map<String, dynamic> mapToList() {
    Map<String, dynamic> _return = {"id": "0"};
    _return["id"] = this.id;
    _return["userId"] = this.userId;
    _return["customerId"] = this.customerId;
    _return["creationDateTime"] = this.creationDateTime.toString();
    _return["comment"] = this.comment;
    _return["status"] = this.status;
    _return["doDateTime"] = this.doDateTime.toString();
    _return["enable"] = this.enable;
    _return["setDateTime"] = this.setDateTime.toString();
    _return["userName"] = this.userName;
    _return["customerMobile"] = this.customerMobile;
    _return["customerName"] = this.customerName;
    _return["hashTags"] = this.hashTags;
    return _return;
  }

  CallDataModel.fromMap(Map<String, dynamic> mapObject) {
    this.id = mapObject["_id"] ?? "";
    this.userId = mapObject["userId"] ?? "123";
    this.customerId = mapObject["customerId"] ?? "123";
    this.creationDateTime =
        DateTime.tryParse(mapObject["creationDateTime"]) ?? DateTime(2000);
    this.comment = mapObject["comment"] ?? "";
    this.status = mapObject["status"] ?? "1";
    this.doDateTime =
        DateTime.tryParse(mapObject["doDateTime"]) ?? DateTime(2000);
    this.enable = mapObject["enable"] ?? 0;
    this.setDateTime =
        DateTime.tryParse(mapObject["setDateTime"]) ?? DateTime(2000);
    this.userName = mapObject["userName"] ?? "Null12";
    this.customerMobile = mapObject["customerMobile"] ?? "09151101602";
    this.customerName = mapObject["customerName"] ?? "Null12";
    this.hashTags = mapObject["hashTags"] ?? "";
  }

  CallDataModel.fromList(List<dynamic> mapObject, int index) {
    this.id = mapObject[index]["id"];
    this.userId = mapObject[index]["userId"];
    this.customerId = mapObject[index]["customerId"];
    this.creationDateTime = mapObject[index]["creationDateTime"];
    this.comment = mapObject[index]["comment"];
    this.status = mapObject[index]["status"];
    this.doDateTime = mapObject[index]["doDateTime"];
    this.enable = mapObject[index]["enable"];
    this.setDateTime = mapObject[index]["setDateTime"];
    this.userName = mapObject[index]["userName"];
    this.customerMobile = mapObject[index]["customerMobile"];
    this.customerName = mapObject[index]["customerName"];
    this.hashTags = mapObject[index]["hashTags"]??"";
  }
}
