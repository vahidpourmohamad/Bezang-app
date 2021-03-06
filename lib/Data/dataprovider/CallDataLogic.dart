import 'package:bestbuy/Data/model/CallDataModel.dart';

import 'package:dio/dio.dart';
import 'DataProviderConfig.dart';

class CallDataLogic {
  static insert(CallDataModel call) async {
    await Dio().post(nodeJsUrl + '/callinsertone', data: call.mapToList());
  }

//  static Future<List<Map<String, dynamic>>> readAll() async {
//    var db = await Db.create(dataSourceUriMongodb);
//    await db.open();
//    var usersCollection = db.collection("Users");
//    final users = await usersCollection.find().toList();
//    return users;
//  }

  static Future<List<dynamic>> readOneCallById(String id) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/findcallbyid', data: {'_id': id});
    print(response.data.runtimeType);
    return (response.data);
  }

  static Future<List<CallDataModel>> findCallBySetting(
      String dateFrom,
      String dateTo,
      String mobile,
      String name,
      String status,
      String hashTags,String userId) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(nodeJsUrl + '/findcallbysetting', data: {
      'name': name,
      'mobile': mobile,
      'status': status,
      'datefrom': dateFrom,
      'dateto': dateTo,
      'hashTags': hashTags,
      'userId':userId
    });
    print(response.data.runtimeType);
    List<CallDataModel> tempList = [];
    for (dynamic item in response.data) {
      print(item);
      tempList.add(CallDataModel.fromMap(item));
    }
    print(tempList.runtimeType);
    return (tempList);
  }

  static Future<List<CallDataModel>> readEnabledCallsByUser(
      String userId) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio()
        .post(nodeJsUrl + '/findenabledcallbyuser', data: {'userId': userId});
    print(response.data.runtimeType);
    List<CallDataModel> tempList = [];
    for (dynamic item in response.data) {
      print(item);
      tempList.add(CallDataModel.fromMap(item));
    }
    print(tempList.runtimeType);
    return (tempList);
  }

  static Future<List<CallDataModel>> readCustomerCallHistoryByUser(
      String userId, String mobile) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(nodeJsUrl + '/findcustomercallhistory',
        data: {'userId': userId, 'mobile': mobile});
    print(userId);
    print(mobile);
    List<CallDataModel> tempList = [];
    for (dynamic item in response.data) {
      print(item);
      tempList.add(CallDataModel.fromMap(item));
    }
    print(tempList.runtimeType);
    return (tempList);
  }

  static Future<List<CallDataModel>> readEnabledInProgressCallsByUser(
      String userId, String fromDate) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(
        nodeJsUrl + '/findenabledinprogresscallbyuser',
        data: {'userId': userId, 'fromDate': fromDate});
    print(response.data);
    List<CallDataModel> tempList = [];
    for (dynamic item in response.data) {
      print(item);
      tempList.add(CallDataModel.fromMap(item));
    }
    print(tempList.runtimeType);
    return (tempList);
  }

  static Future<List<dynamic>> readOneCallByCustomer(String customerId) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio()
        .post(nodeJsUrl + '/customerId', data: {'customerId': customerId});
    print(response.data.runtimeType);
    return (response.data);
  }

  static Future<List<dynamic>> readOneCallByCreationDate(
      String creationDateTime) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(nodeJsUrl + '/findcallbycreatedate',
        data: {'creationDateTime': creationDateTime});
    print(response.data.runtimeType);
    return (response.data);
  }

  static Future<List<dynamic>> readOneCallBySetDate(String setDateTime) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(nodeJsUrl + '/findcallbysetdate',
        data: {'setDateTime': setDateTime});
    print(response.data.runtimeType);
    return (response.data);
  }

  static Future<List<dynamic>> readOneCallByDoDate(String doDateTime) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(nodeJsUrl + '/findcallbydodate',
        data: {'doDateTime': doDateTime});
    print(response.data.runtimeType);
    return (response.data);
  }

  static update(CallDataModel call) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/replacecall', data: call.mapToList());
    print(response.data.runtimeType);
    return (response.data);
  }

//  static deleteById(int id) async {
//    var db = await Db.create(dataSourceUriMongodb);
//    await db.open();
//    var usersCollection = db.collection("Users");
//    await usersCollection.deleteOne({"_id": id});
//  }
}
