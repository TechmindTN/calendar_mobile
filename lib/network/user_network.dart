import 'package:project_calendar/network/apis.dart';
import 'package:dio/dio.dart';

class UserNetwork {
  APIS apis=APIS();

  addUser(data) async {
    Response res = await apis.dio.post(apis.baseUrl + apis.addUser, data: data);
    return res;

  }

  getUser(String id) async {
    Response res = await apis.dio.get("${apis.baseUrl}${apis.getUser}$id/");
    return res;

  }

  getUsers() async {
    Response res = await apis.dio.get(apis.baseUrl+apis.getUsers);


    return res;

  }

  editUser(int id, Map<String, dynamic> data) async {
    Response res =
        await apis.dio.put("${apis.baseUrl}${apis.getUser}$id/", data: data);
    return res;
    // await db.collection('User').doc(id).update(data);
  }

  deleteUser(String id, Map<String, dynamic> data) async {
    Response res = await apis.dio.delete(
      "${apis.baseUrl}${apis.getUser}$id/",
    );
    return res;
  }

 

  login(username,password) async {
    Response res =await apis.dio.post(apis.baseUrl+apis.login,
    data: {
      "username":username,
      "password":password
    }
    );
    return res;

  }

  mobileLogin(username,password) async {
    Response res =await apis.dio.post(apis.baseUrl+apis.mobileLogin,
    data: {
      "username":username,
      "password":password
    }
    );
    return res;

  }
}
