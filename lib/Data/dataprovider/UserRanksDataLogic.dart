import 'package:bestbuy/Data/model/UserRankDataModel.dart';
import 'package:dio/dio.dart';
import 'DataProviderConfig.dart';

 class UserRankDataLogic {
  static Future<UserRankDataModel> readUserReport(String id) async {
    Dio().options.contentType = Headers.jsonContentType;
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
        "0");
    var response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "1"});
    userRankModel.statusDay1 = response.data;
    print(userRankModel.statusDay1);
    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
        data: {'userId': id, 'status': "2"});
    userRankModel.statusDay2 = response.data;
    print(userRankModel.statusDay1);
    response = await Dio().post(nodeJsUrl + '/countprogessscalls',
        data: {'userId': id});
    userRankModel.statusDay3 = response.data;
    int _callDay=int.parse(userRankModel.statusDay1)*200-int.parse(userRankModel.statusDay2)*2+int.parse(userRankModel.statusDay3);
    userRankModel.callDay=_callDay.toString();

    response = await Dio().post(nodeJsUrl + '/countstatuscallsmonth',
        data: {'userId': id, 'status': "1"});
    userRankModel.statusMonth1 = response.data;

    response = await Dio().post(nodeJsUrl + '/countstatuscallsmonth',
        data: {'userId': id, 'status': "2"});
    userRankModel.statusMonth2 = response.data;

    response = await Dio().post(nodeJsUrl + '/countprogessscallsmonth',
        data: {'userId': id});
    userRankModel.statusMonth3 = response.data;

    int _callmonth=int.parse(userRankModel.statusMonth1)*200-int.parse(userRankModel.statusMonth2)*2+int.parse(userRankModel.statusMonth3);
    userRankModel.callMonth=_callmonth.toString();
//    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
//        data: {'userId': id, 'status': "5"});
//    userRankModel.statusDay5 = response.data;
//    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
//        data: {'userId': id, 'status': "6"});
//    userRankModel.statusDay6 = response.data;
//    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
//        data: {'userId': id, 'status': "7"});
//    userRankModel.statusDay7 = response.data;
//    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
//        data: {'userId': id, 'status': "8"});
//    userRankModel.statusDay8 = response.data;
//    response = await Dio().post(nodeJsUrl + '/countstatuscalls',
//        data: {'userId': id, 'status': "9"});
//    userRankModel.statusDay9 = response.data;
//    print(response.data);
    return (userRankModel);
  }
}
