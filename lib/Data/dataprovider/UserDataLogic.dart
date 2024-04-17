import 'package:bestbuy/Data/model/UserDataModel.dart';

import 'package:dio/dio.dart';
import 'DataProviderConfig.dart';

class UserDataLogic {
  static insert(UserDataModel user) async {
    await Dio().post(nodeJsUrl + '/userinsertone', data: user.mapToList());
  }

//  static Future<List<Map<String, dynamic>>> readAll() async {
//    var db = await Db.create(dataSourceUriMongodb);
//    await db.open();
//    var usersCollection = db.collection("Users");
//    final users = await usersCollection.find().toList();
//    return users;
//  }

  static Future<UserDataModel> readOneUserById(String id) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/finduserbyid', data: {'_id': id});
    UserDataModel user = UserDataModel.fromList(response.data, 0);
    return (user);
  }

  static Future<List<dynamic>> readUsersGroupByManagerId(
      String mangerId) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio().post(nodeJsUrl + '/findusersofgroupbymanagerid',
        data: {'mangerId': mangerId});
    print(response.data.runtimeType);
    return (response.data);
  }

  static Future<List<UserDataModel>> readUsersGroupByUserId(String id) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/finduserbyid', data: {'_id': id});
    print(response.data);
    print(response.data.runtimeType);
    UserDataModel user = UserDataModel.fromList(response.data, 0);
    List<dynamic> usersInGroup = [];
    if (user.mangerId != "") {
      usersInGroup = await readUsersGroupByManagerId(user.mangerId);
    }
    print(usersInGroup);
    List<UserDataModel> userList = [];
    for (var obj in usersInGroup) {
      userList.add(UserDataModel.fromDynamic(obj));
    }
    return (userList);
  }

  static Future<UserDataModel> readOneUserByMobile(String mobile) async {
    Dio().options.contentType = Headers.jsonContentType;
    try {
      var response = await Dio()
          .post(nodeJsUrl + '/finduserbymobile', data: {'telephone': mobile});

      print(response.data.runtimeType);
      print(response.data.toString());
      List<dynamic> test = response.data as List<dynamic>;

      if (test.length == 0) {
        UserDataModel user = UserDataModel(
            id: "-1",
            name: "name",
            company: "",
            telephone: "",
            creationDate: DateTime.now(),
            enable: true,
            mangerId: "",
            paymentStatus: true,
            applicationVersion: "",
            gender: true,
            age: 5,
            workScope: "workScope",
            comment: "comment",
            enableComment: "enableComment",
            profilePhoto: "profilePhoto");
        return user;
      } else {
        UserDataModel user = UserDataModel.fromList(response.data, 0);
        return (user);
      }
    } catch (e) {
      UserDataModel user = UserDataModel(
          id: "-1",
          name: "name",
          company: "",
          telephone: "",
          creationDate: DateTime.now(),
          enable: true,
          mangerId: "",
          paymentStatus: true,
          applicationVersion: "",
          gender: true,
          age: 5,
          workScope: "workScope",
          comment: "comment",
          enableComment: "enableComment",
          profilePhoto: "profilePhoto");
      return user;
    }
  }

  static Future<UserDataModel> readOneUserByName(String name) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/finduserbyname', data: {'name': name});
    UserDataModel user = UserDataModel.fromList(response.data, 0);
    return (user);
  }

  static update(UserDataModel user) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response =
        await Dio().post(nodeJsUrl + '/replaceuser', data: user.mapToList());
    print(response.data.runtimeType);
    return (response.data);
  }

  static deleteManager(String Id) async {
    Dio().options.contentType = Headers.jsonContentType;
    var response = await Dio()
        .post(nodeJsUrl + '/manageridtonullbyuserid', data: {'id': Id});
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
