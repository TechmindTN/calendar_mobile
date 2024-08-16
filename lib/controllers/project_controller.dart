import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/models/duration_type.dart';
import 'package:project_calendar/network/project_network.dart';
import 'package:project_calendar/network/task_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';

class ProjectController extends ChangeNotifier {
  bool isLoading = false;
  List<DurationType> durationTypes = [];
  ProjectNetwork proNetwork = ProjectNetwork();
  List<Project> projects = [];
  List<Project> allProjects = [];

  Future getProjects() async {
    isLoading=true;
    projects.clear();
    Response res = await proNetwork.getProjects();
    for (int i = 0; i < res.data.length; i++) {
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;
      Project project=Project.fromJson(data);
      projects.add(project);
      // //notifylisteners();
    }

    isLoading=false;
    notifyListeners();
  }

  Future getDurationTypes() async {
    projects.clear();
    Response res = await proNetwork.getDurationTypes();
    for (int i = 0; i < res.data.length; i++) {
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;
      DurationType durationType=DurationType.fromJson(data);

      durationTypes.add(durationType);
      // //notifylisteners();
    }
    // //notifylisteners();
  }

  sortByName() {
    projects.sort(((a, b) => a.name!.compareTo(b.name!)));
    notifyListeners();
  }

  addProject(
      {required DateTime? deadline,
      required String description,
      required Color color,
      required int duration,
      required String name,
      required DateTime? startingDate,
      required DurationType durationType
      }) async {
        String hexValue =
        color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
    Project pro = Project(
        deadline: deadline,
        color: hexValue,
        description: description,
        duration: duration,

        name: name,
        startingDate: startingDate,
        durationType: durationType);
    Map<String, dynamic> data = pro.toJson();
    Response res = await proNetwork.addProject(data);
    pro.id = res.data['id'];
    projects.add(pro);
    notifyListeners();
    return res;
  }

  editProject(
      {required String name,
      required String description,
      required Color color,
      required int durationType,
      required DateTime startingDate,
      required DateTime deadline,
      required String duration,
      required int index}) async {
    String hexValue =
        color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
    DurationType type =
        durationTypes.firstWhere((element) => element.id == durationType);
    Project project = Project(
        name: name,
        description: description,
        durationType: type,
        color: hexValue,
        startingDate: startingDate,
        deadline: deadline,
        duration: int.parse(duration));

    project.tasks = projects[index].tasks;
    project.employees = projects[index].employees;
    project.id = projects[index].id;
    projects[index] = project;
    Map<String, dynamic> data = project.toJson();

    Response res =
        await proNetwork.editProject(id: project.id!.toString(), data: data);
    notifyListeners();

    return res;
  }

  deleteProject(context, {required String id, required int index}) async {
    await proNetwork.deleteProject(id: id);
    deleteReferencedTasks(context, index);
    projects.removeAt(index);
    notifyListeners();
  }

  deleteReferencedTasks(context, int index) {
    TaskController taskController = Provider.of(context, listen: false);
    int i = 0;
    while (i < taskController.tasks.length) {
      if (taskController.tasks[i].project!.id == projects[index].id) {
        taskController.deleteTask(taskController.tasks[i].id!, context);
        taskController.tasks.removeAt(i);
      } else {
        i++;
      }
    }
    notifyListeners();
  }

  getProjectHistory({id, context}) async {
    Response res = await TaskNetwork().tasksByProject(id);
    if (res.statusCode == 200) {
      return res.data;
    }
  }


  //   getProjectTasks({id, context}) async {
  //     List<Task> projectTasks=[];
  //     for(int i=0;i<projectTasks.length;i++){

  //     }
  //   // Response res = await TaskNetwork().tasksByProject(id);
  //   // if (res.statusCode == 200) {

  //   //   return res.data;
  //   // }
  // }



  searchProject({required String keyword}) {
    allProjects.addAll(projects);
    projects.clear();
    //notifylisteners();
    for(int i=0; i<allProjects.length;i++){
      if(allProjects[i].name!.toUpperCase().contains(keyword.toUpperCase())==true){
        projects.add(allProjects[i]);
        // //notifylisteners();
      }
    }
    notifyListeners();
  }

  clearSearchProject({required TextEditingController keywordController}) {
    projects.clear();
    keywordController.text = "";
    projects.addAll(allProjects);
    allProjects.clear();
    notifyListeners();
  }


  notify(){
    notifyListeners();
  }
}
