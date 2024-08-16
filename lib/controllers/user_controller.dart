// ignore_for_file: unused_element

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/models/employee.dart';
import 'package:project_calendar/network/user_network.dart';
import 'package:project_calendar/screens/Login/LoginScreen.dart';
import 'package:project_calendar/screens/root/root_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserController extends ChangeNotifier {
  User currentUser = User();
  Employee currentEmployee=Employee();
  late SharedPreferences prefs;
  UserNetwork userNetwork = UserNetwork();
  List<User> users = [];
  // ignore: non_constant_identifier_names
  addUser(context,{String? username,String? password,bool? isAdmin}) async {
    Map<String,dynamic> data=User(username: username,password: password,isSuperuser: isAdmin,isActive: true).toJson();

    Response res=await userNetwork.addUser(data);
    if(res.statusCode==201){
      // User user=User.fromJson(res.data);
     
                                return res;
    }
    else{
      SnackBar snackBar=SnackBar(elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Failure!',
                                  message:
                                      'User is not added',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
    }

  }

  checkLogin(context) async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('logged')){
      if(prefs.getBool('logged')==true){
        if(((prefs.containsKey('username')==false)||prefs.containsKey('password')==false)){
          prefs.clear();
          Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginScreen())));
        }
         Future.delayed(const Duration(seconds: 2)).then((value) =>mobileLogin(prefs.getString('username'), prefs.getString('password'), context));
        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const RootScreen()));
      }
      else{
        Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginScreen())));

        
      }
      }
       else{
        Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginScreen())));
      }
    }
  

  logout(context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', false);
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('emp');
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
    // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  login(username,password,context) async {
    Response res=await userNetwork.login(username,password);
    if(res.statusCode==200){
      if(res.data!=null){

      prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged', true);
      prefs.setString('username', username);
      prefs.setString('password', password);
      currentUser=User.fromJson(res.data);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const RootScreen())); 
    }
    
  }
      
  
  else{
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Failure!',
          message: 'Username or password is wrong.',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

  
}


mobileLogin(username,password,context) async {
    Response res=await userNetwork.mobileLogin(username,password);
    if(res.statusCode==200){
      if(res.data!=null){
        print(res.data);
      currentEmployee=Employee.fromJson(res.data['employee']);
      // currentUser.em
      prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged', true);
      prefs.setString('username', username);
      prefs.setString('password', password);
      prefs.setInt('emp', currentEmployee.id!);
      currentUser=User.fromJson(res.data['user']);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const RootScreen())); 
    }
  } 
  else{
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Failure!',
          message: 'Username or password is wrong.',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }  
}


Future<User> getUser(String id) async {
   Response res=await userNetwork.getUser(id);
   Map<String,dynamic> data=res.data() as Map<String,dynamic>;
   User user=User.fromJson(data);
   return user;}
   
  

  getUsers() async {

    Response res=await userNetwork.getUsers();

    for(int i=0;i<res.data.length;i++){
      User user=User.fromJson(res.data[i]);
      users.add(user);
    }

    return users;
  }

  userActivation(int id, User user, context, index) {
    user.isActive = (user.isActive == true) ? false : true;
    Map<String, dynamic> data = user.toJson();
    userNetwork.editUser(id, data);
    Provider.of<EmployeesController>(context, listen: false)
        .employeeActivation(user: user, index: index);
    notifyListeners();
  }



  notify() {
    notifyListeners();
  }
}
