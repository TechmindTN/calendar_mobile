import 'package:project_calendar/models/project.dart';
import 'package:project_calendar/models/protask.dart';
import 'package:project_calendar/network/protask_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProtaskController extends ChangeNotifier{
  List<Protask> protasks=[];
  List<bool> checks=[];
    List<Protask> todotasks=[];
  List<Protask> doingtasks=[];
  List<Protask> donetasks=[];
  // late Protask selectedProtask;
  ProtaskNetwork protaskNetwork=ProtaskNetwork();

  Future getProtasks(context,project) async {
    protasks.clear();
    checks.clear();
    todotasks.clear();
    doingtasks.clear();
    donetasks.clear();
    Response res = await protaskNetwork.getProtasks(project.id);
    for (int i = 0; i < res.data.length; i++) {
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;
      Protask protask = Protask.fromJson(data);
      protasks.add(protask);
      if(protask.status=="Pending"){
        todotasks.add(protask);
        // checks.add(false);
      }
      else if(protask.status=="In progress"){
        doingtasks.add(protask);
      }
      else if(protask.status=="Done"){
       donetasks.add(protask);
      }
    }
    notifyListeners();
    return protasks;
    
  }


  addprotask( {required Project project,required String title,required String description,required String color,required String status}) async {
    Map<String,dynamic> data={
      'project_id':project.id,
      'title':title,
      'description':description,
      'status':status,
      'color':color
    };
    Response res = await protaskNetwork.addProtask(data);
    Protask protask=Protask.fromJson(res.data);
    protask.id = res.data['id'];
    protasks.add(protask);
    // checks.insert(0,false);
    if(protask.status=="Pending"){
        todotasks.add(protask);
      }
      else if(protask.status=="In progress"){
        doingtasks.add(protask);

      }
    else if(protask.status=="Done"){
        donetasks.add(protask);
      }
    notifyListeners();
  }

  upgradeProtask({required Protask protask}) async {
    String status='';
    if(protask.status=='In progress'){
      
      doingtasks.remove(protask);
      status='Done';
    }
    else if(protask.status=='Pending'){
      todotasks.remove(protask);
      status='In progress';
    }
    Map<String,dynamic> data={
      'project_id':protask.project!.id,
      'status':status
    };
    Response res =await protaskNetwork.editProtask(id: protask.id!, data: data);
    protasks.remove(protask);
    protask=Protask.fromJson(res.data);
    protasks.add(protask);
    
    if(protask.status=='Done'){
      donetasks.add(protask);
    }
    else if(protask.status=='In progress'){
      doingtasks.add(protask);
    }
  notifyListeners();
  }

  changeState(int index) async {
    
    
     if(checks[index]==false){
              checks[index]=true;
              protasks[index].status="Done";
              }
              else{
                checks[index]=false;
              protasks[index].status="Pending";
              }
              Map<String,dynamic> data={
      'project_id':protasks[index].project!.id,
      'status': protasks[index].status
    };
    Response res =await protaskNetwork.editProtask(id: protasks[index].id!, data: data);
    // print(index);
   
              notify();
  }




  downgradeProtask({required Protask protask}) async {
    String status='';
    if(protask.status=='In progress'){
      status='Pending';
      doingtasks.remove(protask);
    }
    else if(protask.status=='Done'){
      donetasks.remove(protask);
      status='In progress';
    }
    Map<String,dynamic> data={
      'project_id':protask.project!.id,
      'status':status
    };
    Response res =await protaskNetwork.editProtask(id: protask.id!, data: data);
    protasks.remove(protask);
    protask=Protask.fromJson(res.data);
    protasks.add(protask);
    if(protask.status=='Pending'){
      todotasks.add(protask);
    }
    else if(protask.status=='In progress'){
      doingtasks.add(protask);
    }
  notifyListeners();
  }

  

  notify(){
    notifyListeners();
  } 

}