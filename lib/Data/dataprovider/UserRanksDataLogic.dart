import 'package:bestbuy/Data/dataprovider/UserDataLogic.dart';
import 'package:bestbuy/Data/model/CDRDataModel.dart';
import 'package:bestbuy/Data/model/UserDataModel.dart';
import 'package:bestbuy/Data/model/UserRankDataModel.dart';
import 'package:bestbuy/config/ClsLoginCnf.dart';
import 'package:dio/dio.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'DataProviderConfig.dart';

class UserRankDataLogic {
  static Future<UserRankDataModel> readUserReport(String id) async {
    Dio().options.contentType = Headers.jsonContentType;
    UserDataModel userTemp = await UserDataLogic.readOneUserById(id);
    UserRankDataModel userRankModel = UserRankDataModel(
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0",
        "0");
    var response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "1"});
    userRankModel.statusDay1 = response.data;
    print(userRankModel.statusDay1);
    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "2"});
    userRankModel.statusDay2 = response.data;
    print(userRankModel.statusDay1);
    response = await Dio()
        .post(nodeJsUrl + '/countprogessscalls', data: {'userId': id});
    userRankModel.statusDay3 = response.data;
    int _callDay = int.parse(userRankModel.statusDay1) * 200 +
        int.parse(userRankModel.statusDay3);
    userRankModel.callDay = _callDay.toString();

    response = await Dio().post(nodeJsUrl + '/countstatuscallsmonth',
        data: {'userId': id, 'status': "1"});
    userRankModel.statusMonth1 = response.data;

    response = await Dio().post(nodeJsUrl + '/countstatuscallsmonth',
        data: {'userId': id, 'status': "2"});
    userRankModel.statusMonth2 = response.data;

    response = await Dio()
        .post(nodeJsUrl + '/countprogessscallsmonth', data: {'userId': id});
    userRankModel.statusMonth3 = response.data;

    int _callmonth = int.parse(userRankModel.statusMonth1) * 200 -
        int.parse(userRankModel.statusMonth2) * 2 +
        int.parse(userRankModel.statusMonth3);
    userRankModel.callMonth = _callmonth.toString();
    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "5"});
    userRankModel.statusDay5 = response.data;
    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "6"});
    userRankModel.statusDay6 = response.data;
    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "7"});
    userRankModel.statusDay7 = response.data;
    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "8"});
    userRankModel.statusDay8 = response.data;
    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "9"});
    userRankModel.statusDay9 = response.data;

    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "9"});
    userRankModel.statusDay9 = response.data;

    DateTime n = DateTime.now();
    DateTime fd = DateTime(n.year, n.month, n.day, 0, 0, 0);
    DateTime td = DateTime(n.year, n.month, n.day, 23, 59, 59);
    response = await Dio().post(nodeJsUrl + '/findcdrbydatebyorigin', data: {
      'datefrom': fd.toString(),
      'dateto': td.toString(),
      "origin": userTemp.age.toString()
    });

    int max = 0, min = 100000, count = 0, total = 0;
    List<CDRDataModel> tempList = [];
    total = 0;
    for (dynamic item in response.data) {
      print(item);
      CDRDataModel tempItem = CDRDataModel.fromMap(item);

      tempList.add(tempItem);
      count = count + 1;
      total += tempItem.duration;
      if (min > tempItem.duration) {
        min = tempItem.duration;
      }
      if (max < tempItem.duration) {
        max = tempItem.duration;
      }
    }
    userRankModel.averageSec = (total / count).toString();
    userRankModel.callCount = count.toString();
    userRankModel.totalSec = total.toString();
    userRankModel.minCallTime = min.toString();
    userRankModel.maxCallTime = max.toString();

//findcdrbydatebyorigin
//    print(response.data);

    return (userRankModel);
  }
}
