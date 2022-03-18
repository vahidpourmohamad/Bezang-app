import 'dart:core';

class UserDataModel {
  late String id;
  late String name;
  late String company;
  late String telephone;
  late DateTime creationDate;
  late bool enable;
  late String mangerId;
  late bool paymentStatus;
  late String applicationVersion;
  late bool gender;
  late int age;
  late String workScope;
  late String comment;
  late String enableComment;
  late String profilePhoto;

  void mapToUser(Map<String, dynamic> mapObject) {
    this.id = mapObject["id"];
    this.name = mapObject["name"];
    this.company = mapObject["company"];
    this.telephone = mapObject["telephone"];
    this.creationDate = mapObject["creationDate"];
    this.enable = mapObject["enable"];
    this.mangerId = mapObject["mangerId"];
    this.paymentStatus = mapObject["paymentStatus"];
    this.applicationVersion = mapObject["applicationVersion"];
    this.gender = mapObject["gender"];
    this.age = mapObject["age"];
    this.workScope = mapObject["workScope"];
    this.comment = mapObject["comment"];
    this.enableComment = mapObject["enableComment"];
    this.profilePhoto = mapObject["profilePhoto"];
  }

  Map<String, dynamic> mapToList() {
    Map<String, dynamic> _return = {"id": "0"};
    _return["id"] = this.id;
    _return["name"] = this.name;
    _return["company"] = this.company;
    _return["telephone"] = this.telephone;
    _return["creationDate"] = this.creationDate.toString();
    _return["enable"] = this.enable;
    _return["mangerId"] = this.mangerId;
    _return["paymentStatus"] = this.paymentStatus;
    _return["applicationVersion"] = this.applicationVersion;
    _return["gender"] = this.gender;
    _return["age"] = this.age;
    _return["workScope"] = this.workScope;
    _return["comment"] = this.comment;
    _return["enableComment"] = this.enableComment;
    _return["profilePhoto"] = this.profilePhoto;
    return _return;
  }

  UserDataModel({
    required this.id,
    required this.name,
    required this.company,
    required this.telephone,
    required this.creationDate,
    required this.enable,
    required this.mangerId,
    required this.paymentStatus,
    required this.applicationVersion,
    required this.gender,
    required this.age,
    required this.workScope,
    required this.comment,
    required this.enableComment,
    required this.profilePhoto,
  });

  UserDataModel.fromMap(Map<String, dynamic> mapObject) {
    this.id = mapObject["id"];
    this.name = mapObject["name"];
    this.company = mapObject["company"];
    this.telephone = mapObject["telephone"];
    this.creationDate = mapObject["creationDate"];
    this.enable = mapObject["enable"];
    this.mangerId = mapObject["mangerId"];
    this.paymentStatus = mapObject["paymentStatus"];
    this.applicationVersion = mapObject["applicationVersion"];
    this.gender = mapObject["gender"];
    this.age = mapObject["age"];
    this.workScope = mapObject["workScope"];
    this.comment = mapObject["comment"];
    this.enableComment = mapObject["enableComment"];
    this.profilePhoto = mapObject["profilePhoto"];
  }

  UserDataModel.fromList(List<dynamic> mapObject, int index) {
    print(mapObject[index].runtimeType);
    print(mapObject.runtimeType);
    this.id = mapObject[index]["_id"];
    this.name = mapObject[index]["name"];
    this.company = mapObject[index]["company"];
    this.telephone = mapObject[index]["telephone"];
    this.creationDate = DateTime.parse(mapObject[index]["creationDate"]);
    this.enable = mapObject[index]["enable"];
    this.mangerId = mapObject[index]["mangerId"];
    this.paymentStatus = mapObject[index]["paymentStatus"];
    this.applicationVersion = mapObject[index]["applicationVersion"];
    this.gender = mapObject[index]["gender"];
    this.age = mapObject[index]["age"];
    this.workScope = mapObject[index]["workScope"];
    this.comment = mapObject[index]["comment"];
    this.enableComment = mapObject[index]["enableComment"];
    this.profilePhoto = mapObject[index]["profilePhoto"] ?? "";
  }

  UserDataModel.fromDynamic(dynamic mapObject) {
    this.id = mapObject["_id"];
    this.name = mapObject["name"];
    this.company = mapObject["company"];
    this.telephone = mapObject["telephone"];
    this.creationDate = DateTime.parse(mapObject["creationDate"]);
    this.enable = mapObject["enable"];
    this.mangerId = mapObject["mangerId"];
    this.paymentStatus = mapObject["paymentStatus"];
    this.applicationVersion = mapObject["applicationVersion"];
    this.gender = mapObject["gender"];
    this.age = mapObject["age"];
    this.workScope = mapObject["workScope"];
    this.comment = mapObject["comment"];
    this.enableComment = mapObject["enableComment"];
    this.profilePhoto = mapObject["profilePhoto"]??"";
  }
}
