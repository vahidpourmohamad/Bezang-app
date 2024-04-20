import 'package:bestbuy/Data/model/CDRDataModel.dart';
import 'package:bestbuy/Data/model/CallDataModel.dart';

import 'package:dio/dio.dart';
import 'package:shamsi_date/shamsi_date.dart';
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

  static Future<List<CDRDataModel>> readCDRByMobile(
      String _mobile, String id) async {
    Dio().options.contentType = Headers.jsonContentType;
    print(_mobile);
    var response = await Dio().post(nodeJsUrl + '/findcdrbydestination',
        data: {'destination': _mobile});

    List<CDRDataModel> tempList = [];
    for (dynamic item in response.data) {
      tempList.add(CDRDataModel.fromMap(item));
    }
    return (tempList);
  }

  static Future<List<CDRDataModel>> readCDRByInternalByDay(
      DateTime reportDay, String internal) async {
    Dio().options.contentType = Headers.jsonContentType;
    print(internal);
    internal = "103";
    DateTime n = reportDay;
    DateTime fd = DateTime(n.year, n.month, n.day, 0, 0, 0);
    DateTime td = DateTime(n.year, n.month, n.day, 23, 59, 59);
    var response = await Dio().post(nodeJsUrl + '/findcdrbydatebyorigin',
        data: {
          'origin': internal,
          'datefrom': fd.toString(),
          'dateto': td.toString()
        });

    List<CDRDataModel> tempList = [];
    for (dynamic item in response.data) {
      tempList.add(CDRDataModel.fromMap(item));
    }
    return (tempList);
  }

  static Future<List<CallDataModel>> findCallBySetting(
      String dateFrom,
      String dateTo,
      String mobile,
      String name,
      String status,
      String hashTags,
      String userId) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(nodeJsUrl + '/findcallbysetting', data: {
      'name': name,
      'mobile': mobile,
      'status': status,
      'datefrom': dateFrom,
      'dateto': dateTo,
      'hashTags': hashTags,
      'userId': userId
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

  static Future<List<CallDataModel>> readActivityByUserByDate(
      String userId, DateTime reportDay) async {
    Dio().options.contentType = Headers.jsonContentType;
    print("findactivitybyuserbydate");
    DateTime Now = reportDay;
    DateTime fromDate = DateTime(Now.year, Now.month, Now.day, 0, 0, 0);
    DateTime toDate = DateTime(Now.year, Now.month, Now.day, 23, 59, 59);
    print(fromDate);
    print(toDate);
    var response = await Dio().post(nodeJsUrl + '/findactivitybyuserbydate',
        data: {
          'userId': userId,
          'fromDate': fromDate.toString(),
          'toDate': toDate.toString()
        });
    print(userId);

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
