import 'dart:core';

class CDRDataModel {
  late String id;
  late String uniqueid;
  late String APIId;
  late DateTime callDate;
  late int bilsec;
  late int duration;
  late String origin;
  late String destination;
  late String voice;

  CDRDataModel({
    required this.id,
    required this.uniqueid,
    required this.APIId,
    required this.callDate,
    required this.bilsec,
    required this.duration,
    required this.origin,
    required this.destination,
    required this.voice,
  });

  void mapToCDR(Map<String, dynamic> mapObject) {
    this.id = mapObject["_id"];
    this.uniqueid = mapObject["uniqueid"];
    this.APIId = mapObject["APIId"];
    this.callDate = mapObject["callDate"];
    this.bilsec = mapObject["bilsec"];
    this.duration = mapObject["duration"];
    this.origin = mapObject["origin"];
    this.destination = mapObject["destination"];
    this.voice = mapObject["voice"];
  }

  Map<String, dynamic> mapToList() {
    Map<String, dynamic> _return = {"id": "0"};
    _return["_id"] = this.id;
    _return["uniqueid"] = this.uniqueid.toString();
    _return["APIId"] = this.APIId.toString();
    _return["callDate"] = this.callDate.toString();
    _return["bilsec"] = this.bilsec.toString();
    _return["duration"] = this.duration.toString();
    _return["origin"] = this.origin.toString();
    _return["destination"] = this.destination.toString();
    _return["voice"] = this.voice.toString();

    return _return;
  }

  CDRDataModel.fromMap(Map<String, dynamic> mapObject) {
    this.id = mapObject["_id"] ?? "";
    this.uniqueid = mapObject["uniqueid"] ?? "123";
    this.APIId = mapObject["APIId"] ?? "123";
    this.callDate = DateTime.tryParse(mapObject["callDate"]) ?? DateTime(2000);
    this.bilsec = mapObject["bilsec"] ?? "";
    this.duration = mapObject["duration"] ?? "1";
    this.origin = mapObject["origin"] ?? "1";
    this.destination = mapObject["destination"] ?? "1";
    this.voice = mapObject["voice"] ?? "1";
  }

  CDRDataModel.fromList(List<dynamic> mapObject, int index) {
    this.id = mapObject[index]["_id"];
    this.uniqueid = mapObject[index]["uniqueid"];
    this.APIId = mapObject[index]["APIId"];
    this.callDate = mapObject[index]["callDate"];
    this.bilsec = mapObject[index]["bilsec"];
    this.duration = mapObject[index]["duration"];
    this.origin = mapObject[index]["origin"];
    this.destination = mapObject[index]["destination"];
    this.voice = mapObject[index]["voice"];
  }
}
