import 'dart:core';


class CustomerDataModel {
  late String id;
  late String name;
  late String company;
  late String telephone;
  late String comment;
  late String workgroup;
  late String bank;
  late List<String> creationUserList;
  late bool enable;
  late String enableComment;
  late DateTime creationDate;

  CustomerDataModel(
      {required this.id,
      required this.name,
      required this.company,
      required this.telephone,
      required this.comment,
      required this.workgroup,
      required this.bank,
      required this.creationUserList,
      required this.enable,
      required this.enableComment,
      required this.creationDate});

  void mapToCustomer(Map<String, dynamic> mapObject) {
    this.id = mapObject["_id"];
    this.name = mapObject["name"];
    this.company = mapObject["company"];
    this.telephone = mapObject["telephone"];
    this.comment = mapObject["comment"];
    this.workgroup = mapObject["workgroup"];
    this.bank = mapObject["bank"];
    this.creationUserList = mapObject["creationUserList"];
    this.enable = mapObject["enable"];
    this.enableComment = mapObject["enableComment"];
    this.creationDate = mapObject["creationDate"];
  }

  Map<String, dynamic> mapToList() {
    Map<String, dynamic> _return = {"id": "0"};
    _return["_id"] = this.id;
    _return["name"] = this.name;
    _return["company"] = this.company;
    _return["telephone"] = this.telephone;
    _return["comment"] = this.comment;
    _return["workgroup"] = this.workgroup;
    _return["bank"] = this.bank;
    _return["creationUserList"] = this.creationUserList;
    _return["enableComment"] = this.enableComment;
    _return["enable"] = this.enable;
    _return["creationDate"] = this.creationDate.toString();
    return _return;
  }

  CustomerDataModel.fromMap(Map<String, dynamic> mapObject) {
    this.id = mapObject["_id"]??"";
    this.name = mapObject["name"]??"";
    this.company = mapObject["company"]??"";
    this.telephone = mapObject["telephone"]??"";
    this.comment = mapObject["comment"]??"";
    this.workgroup = mapObject["workgroup"]??"";
    this.bank = mapObject["bank"]??"";
    //this.creationUserList = mapObject[index]["creationUserList"].cast<String>();
    this.creationUserList = new List<String>.from(mapObject["creationUserList"]);
    this.enableComment = mapObject["enableComment"]??"";
    this.creationDate =DateTime.tryParse(mapObject["creationDate"])!;
    this.enable = mapObject["enable"]??"";
  }

  CustomerDataModel.fromList(List<dynamic> mapObject, int index) {
    this.id = mapObject[index]["_id"];
    this.name = mapObject[index]["name"];
    this.company = mapObject[index]["company"];
    this.telephone = mapObject[index]["telephone"];
    this.comment = mapObject[index]["comment"];
    this.workgroup = mapObject[index]["workgroup"];
    this.bank = mapObject[index]["bank"];
    //this.creationUserList = mapObject[index]["creationUserList"].cast<String>();
    this.creationUserList = new List<String>.from(mapObject[index]["creationUserList"]);
    this.enableComment = mapObject[index]["enableComment"];
    this.creationDate =DateTime.tryParse(mapObject[index]["creationDate"])!;
    this.enable = mapObject[index]["enable"];
  }//samindavoodiz
}
