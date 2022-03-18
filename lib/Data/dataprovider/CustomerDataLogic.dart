import 'package:bestbuy/Data/model/CustomerDataModel.dart';

import 'package:dio/dio.dart';
import 'DataProviderConfig.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomerDataLogic {
  static insert(CustomerDataModel customer) async {
    await Dio().post('http://pouncing-denim-chip.glitch.me/customerinsertone',
        data: customer.mapToList());
  }

//  static Future<List<Map<String, dynamic>>> readAll() async {
//    var db = await Db.create(dataSourceUriMongodb);
//    await db.open();
//    var usersCollection = db.collection("Users");
//    final users = await usersCollection.find().toList();
//    return users;
//  }

  static Future<List<dynamic>> readOneCustomerById(String id) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/findcustomerbyid', data: {'_id': id});
    print(response.data.runtimeType);
    return (response.data);
  }

  static Future<List<dynamic>> readOneCustomerByMobile(String mobile) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio()
        .post(nodeJsUrl + '/findcustomerbymobile', data: {'telephone': mobile});
    print(response.data.runtimeType);
    return (response.data);
  }

  static Future<CustomerDataModel> readOneCustomerByBankUserCall(
      String mobile, String userId, bool userCreated) async {
    if (mobile.isNumeric() == true) {
      Dio().options.contentType = Headers.jsonContentType;
      var response = await Dio().post(nodeJsUrl + '/findcustomerbymobile',
          data: {'telephone': mobile});
      print(response.data.runtimeType);
      CustomerDataModel mdl = CustomerDataModel.fromList(response.data, 0);
      return (mdl);
    } else {
      if (userCreated == true) {
        Dio().options.contentType = Headers.jsonContentType;
        var response = await Dio().post(nodeJsUrl + '/findcustomerbymobilebybank',
            data: {'telephone': mobile,'bank':userId});
        print(response.data.runtimeType);
        CustomerDataModel mdl = CustomerDataModel.fromList(response.data, 0);
        return (mdl);
      } else {
        Dio().options.contentType = Headers.jsonContentType;
        var response = await Dio().post(
            nodeJsUrl + '/findcustomerbybankandusercall',
            data: {'bank': mobile, 'userId': userId});
        print(response.data.runtimeType);
        print(response.data);
        if (response.data == "") {
          CustomerDataModel mdl = CustomerDataModel(
              id: "",
              name: "",
              company: "",
              telephone: "-1",
              comment: "comment",
              workgroup: "workgroup",
              bank: "bank",
              creationUserList: [],
              enable: true,
              enableComment: "enableComment",
              creationDate: DateTime.now());
          return (mdl);
        } else {
          CustomerDataModel mdl = CustomerDataModel.fromMap(response.data);
          return (mdl);
        }
      }
    }
  }

  static Future<CustomerDataModel> readOneCustomerByMobileToModel(
      String mobile) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio()
        .post(nodeJsUrl + '/findcustomerbymobile', data: {'telephone': mobile});
    print(response.data.runtimeType);
    CustomerDataModel mdl = CustomerDataModel.fromList(response.data, 0);
    return (mdl);
  }

  static Future<List<dynamic>> readOnecustomerByName(String name) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/finduserbyname', data: {'name': name});
    print(response.data.runtimeType);
    return (response.data);
  }

  static update(CustomerDataModel customer) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio()
        .post(nodeJsUrl + '/replacecustomer', data: customer.mapToList());
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
