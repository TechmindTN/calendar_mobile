import 'package:project_calendar/models/employee.dart';
import 'package:project_calendar/models/permatask.dart';
import 'package:project_calendar/network/permatask_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PermataskController extends ChangeNotifier{
  List<Permatask> permatasks=[];
  List<bool> checks=[];
  //   List<Permatask> todotasks=[];
  // List<Permatask> doingtasks=[];
  // List<Permatask> donetasks=[];
  // late Permatask selectedPermatask;
  PermataskNetwork permataskNetwork=PermataskNetwork();

  Future getPermatasks(context,employee) async {
    permatasks.clear();
    checks.clear();
    // todotasks.clear();
    // doingtasks.clear();
    // donetasks.clear();
    Response res = await permataskNetwork.getPermatasks(employee.id);
    for (int i = 0; i < res.data.length; i++) {
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;
      Permatask permatask = Permatask.fromJson(data);
      permatasks.add(permatask);
      if(permatask.status=="Pending"){
        checks.add(false);
      }
      // else if(permatask.status=="In progress"){
      //   doingtasks.add(permatask);

      else{
        checks.add(true);
      }
    }
    notifyListeners();
    return permatasks;
    
  }


  addpermatask( {required Employee employee,required String title,required String description,required String color,required String status}) async {
    Map<String,dynamic> data={
      'employee_id':employee.id,
      'title':title,
      'description':description,
      'status':status,
      'color':color
    };
    Response res = await permataskNetwork.addPermatask(data);
    Permatask permatask=Permatask.fromJson(res.data);
    permatask.id = res.data['id'];
    permatasks.insert(0,permatask);
    checks.insert(0,false);
    // if(permatask.status=="Pending"){
    //     todotasks.add(permatask);
    //   }
    //   else if(permatask.status=="In progress"){
    //     doingtasks.add(permatask);

    //   }else if(permatask.status=="Done"){
    //     donetasks.add(permatask);
    //   }
    notifyListeners();
  }

  upgradePermatask({required Permatask permatask}) async {
    String status='';
    // if(permatask.status=='In progress'){
    //   status='Done';
    //   doingtasks.remove(permatask);
    // }
    // else if(permatask.status=='Pending'){
    //   todotasks.remove(permatask);
    //   status='In progress';
    // }
    Map<String,dynamic> data={
      'employee_id':permatask.employee!.id,
      'status':status
    };
    Response res =await permataskNetwork.editPermatask(id: permatask.id!, data: data);
    permatasks.remove(permatask);
    permatask=Permatask.fromJson(res.data);
    permatasks.add(permatask);
    
    // if(permatask.status=='Done'){
    //   donetasks.add(permatask);
    // }
    // else if(permatask.status=='In progress'){
    //   doingtasks.add(permatask);
    // }
  notifyListeners();
  }

  changeState(int index) async {
    
    
     if(checks[index]==false){
              checks[index]=true;
              permatasks[index].status="Done";
              }
              else{
                checks[index]=false;
              permatasks[index].status="Pending";
              }
              Map<String,dynamic> data={
      'employee_id':permatasks[index].employee!.id,
      'status': permatasks[index].status
    };
    Response res =await permataskNetwork.editPermatask(id: permatasks[index].id!, data: data);
    // print(index);
   
              notify();
  }




  downgradePermatask({required Permatask permatask}) async {
    String status='';
    // if(permatask.status=='In progress'){
    //   status='Pending';
    //   doingtasks.remove(permatask);
    // }
    // else if(permatask.status=='Done'){
    //   donetasks.remove(permatask);
    //   status='In progress';
    // }
    Map<String,dynamic> data={
      'employee_id':permatask.employee!.id,
      'status':status
    };
    Response res =await permataskNetwork.editPermatask(id: permatask.id!, data: data);
    permatasks.remove(permatask);
    permatask=Permatask.fromJson(res.data);
    permatasks.insert(0,permatask);
    // if(permatask.status=='Pending'){
    //   todotasks.add(permatask);
    // }
    // else if(permatask.status=='In progress'){
    //   doingtasks.add(permatask);
    // }
  notifyListeners();
  }

  notify(){
    notifyListeners();
  } 


  deletePermatask({required int id, context,required int index}) async {
    await permataskNetwork.deletePermatask(id.toString());
    
    permatasks.removeAt(index);
    checks.removeAt(index);
    notifyListeners();

    Navigator.pop(context);
        notifyListeners();

    // final snackBar = SnackBar(
    //   elevation: 0,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   content: AwesomeSnackbarContent(
    //     title: 'Success!',
    //     message: 'Task succussfully deleted.',
    //     contentType: ContentType.success,
    //   ),
    // );
    // ScaffoldMessenger.of(context)
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(snackBar);
  }

}