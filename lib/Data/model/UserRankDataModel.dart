import 'dart:core';

class UserRankDataModel {
  late String callMonth;

  late String callDay;

  late String statusDay1;

  late String statusDay2;

  late String statusDay3;

  late String statusDay4;

  late String statusDay5;

  late String statusDay6;

  late String statusDay7;

  late String statusDay8;

  late String statusDay9;

  late String statusMonth1;

  late String statusMonth2;

  late String statusMonth3;

  late String statusMonth4;

  late String statusMonth5;

  late String statusMonth6;

  late String statusMonth7;

  late String statusMonth8;

  late String statusMonth9;

  late String inProgressCount;

  late String newCustomerMonth;

  UserRankDataModel(
      this.callMonth,
      this.callDay,
      this.statusDay1,
      this.statusDay2,
      this.statusDay3,
      this.statusDay4,
      this.statusDay5,
      this.statusDay6,
      this.statusDay7,
      this.statusDay8,
      this.statusDay9,
      this.statusMonth1,
      this.statusMonth2,
      this.statusMonth3,
      this.statusMonth4,
      this.statusMonth5,
      this.statusMonth6,
      this.statusMonth7,
      this.statusMonth8,
      this.statusMonth9,
      this.inProgressCount,
      this.newCustomerMonth);

  UserRankDataModel.stringToModel(String data
     ){
    var temp= [];
    temp= data.split("*");
    this.callMonth=temp[0];
    this.callDay=temp[1];
    this.statusDay1=temp[2];
    this.statusDay2=temp[3];
    this.statusDay3=temp[4];
    this.statusDay4=temp[5];
    this.statusDay5=temp[6];
    this.statusDay6=temp[7];
    this.statusDay7=temp[8];
    this.statusDay8=temp[9];
    this.statusDay9=temp[10];
    this.statusMonth1=temp[11];
    this.statusMonth2=temp[12];
    this.statusMonth3=temp[13];
    this.statusMonth4=temp[14];
    this.statusMonth5=temp[15];
    this.statusMonth6=temp[16];
    this.statusMonth7=temp[17];
    this.statusMonth8=temp[18];
    this.statusMonth9=temp[19];
    this.inProgressCount=temp[20];
    this.newCustomerMonth=temp[21];
  }
//https://www.pornhub.com/view_video.php?viewkey=ph613b3d0deb0ef
//  Map<String, dynamic> mapToList() {
//    Map<String, dynamic> _return = {"id": "0"};
//    _return["_id"] = this.id;
//    _return["name"] = this.name;
//    _return["company"] = this.company;
//    _return["telephone"] = this.telephone;
//    _return["comment"] = this.comment;
//    _return["workgroup"] = this.workgroup;
//    _return["bank"] = this.bank;
//    _return["creationUserList"] = this.creationUserList;
//    _return["enableComment"] = this.enableComment;
//    _return["enable"] = this.enable;
//    _return["creationDate"] = this.creationDate.toString();
//    return _return;
//  }
//
//  UserRankDataModel.fromMap(Map<String, dynamic> mapObject) {
//    this.id = mapObject["_id"];
//    this.name = mapObject["name"];
//    this.company = mapObject["company"];
//    this.telephone = mapObject["telephone"];
//    this.comment = mapObject["comment"];
//    this.workgroup = mapObject["workgroup"];
//    this.bank = mapObject["bank"];
//    this.creationUserList = mapObject["creationUserList"];
//    this.enableComment = mapObject["enableComment"];
//    this.creationDate = mapObject["creationDate"];
//    this.enable = mapObject["enable"];
//  }
//
//  UserRankDataModel.fromList(List<dynamic> mapObject, int index) {
//    this.id = mapObject[index]["_id"];
//    this.name = mapObject[index]["name"];
//    this.company = mapObject[index]["company"];
//    this.telephone = mapObject[index]["telephone"];
//    this.comment = mapObject[index]["comment"];
//    this.workgroup = mapObject[index]["workgroup"];
//    this.bank = mapObject[index]["bank"];
//    //this.creationUserList = mapObject[index]["creationUserList"].cast<String>();
//    this.creationUserList = new List<String>.from(mapObject[index]["creationUserList"]);
//    this.enableComment = mapObject[index]["enableComment"];
//    this.creationDate =DateTime.tryParse(mapObject[index]["creationDate"])!;
//    this.enable = mapObject[index]["enable"];
//  }//samindavoodiz
}
