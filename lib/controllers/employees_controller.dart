import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/models/department.dart';
import 'package:project_calendar/network/employee_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../models/employee.dart';
import '../models/user.dart';
import '../widgets/calendar/calendar_widgets.dart';


class EmployeesController extends ChangeNotifier {
  List<double> heights = [];
  EmployeeNetwork empNetwork = EmployeeNetwork();
  List<Employee> employees = [];
  List<Employee> allEmployees = [];
  List<Widget> employeesRow = [];
  List<Department> departments=[];
  Employee? selectedEmp;
  Future initEmployees(context) async {
    heights.clear();
    employees.clear();
    allEmployees.clear();
    employeesRow.clear();
    getEmployees(context).then((value) {
      for (int i = 0; i < employees.length; i++) {
        employeesRow.add(EmpRowWidget(
          empName: employees[i].name!, index: i,employee: employees[i],));
        heights.add(5.h); 
        // //notifylisteners();
      }
      // employeesRow.add(EmpRowWidget(
      //     empName: '7ama', index: employees.length));
      //     heights.add(5.h); 
      //     employees.add(Employee());
      if (employeesRow.length<14){
        int rest=14-employeesRow.length;

        for (int i = 0; i < rest; i++) {
        employeesRow.add(EmpRowWidget(
          empName: "", index: i,employee: Employee(),));
                  heights.add(5.h); 
        employees.add(Employee());
        // //notifylisteners();
      }

      }
      // notifyListeners();
    });
    // noti
    // notifyListeners();
  }

   Future getDepartments(context) async {
    departments.clear();
   
    Response res = await empNetwork.getDepartments();

    for (int i = 0; i < res.data.length; i++) {
      
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;


      Department dep = Department.fromJson(data);

      departments.add(dep);

      // //notifylisteners();
    }
    // //notifylisteners();
  }

  Future getEmployees(context) async {
    employees.clear();

    allEmployees.clear();
    employeesRow.clear();

    Response res = await empNetwork.getEmployees();

    for (int i = 0; i < res.data.length; i++) {
      
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;


      Employee emp = Employee.fromJson(data);


      employees.add(emp);

      allEmployees.add(emp);

      // //notifylisteners();
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  addEmployee(context, TaskController taskController,
      {String? username,
      String? password,
      String? name,
      int? department}) async {
    Response userRef =
        await Provider.of<UserController>(context, listen: false).addUser(
      context,

            username: username, password: password, isAdmin: false,
            );
            Department dep=departments.firstWhere((element) => element.id==department);
    Employee emp = Employee(department: dep, name: name,user: User.fromJson(userRef.data));
    Map<String, dynamic> data = emp.toJson();
 
    Response res =await empNetwork.addEmployee(data);
    emp.id=res.data['id'];
    employees.add(emp);
    allEmployees.add(emp);
    employeesRow.add(EmpRowWidget(
        empName: emp.name!,
        index: employees.length-1,employee: employees[employees.length-1],));
    heights.add(5.h);
    notifyListeners();
  }

  deleteEmployee(String? id, context, index) {
    empNetwork.deleteEmployee(id: id);
    deleteReferencedTasks(context, index);
    employees.removeAt(index);
    // employeesRow.removeAt(index);
    // heights.removeLast();
    notifyListeners();
  }

  deleteReferencedTasks(context, int index) {
    TaskController taskController = Provider.of(context, listen: false);
    int i = 0;
    while (i < taskController.tasks.length) {
      if (taskController.tasks[i].employee!.id == employees[index].id) {
        taskController.deleteTask(taskController.tasks[i].id!, context);
        taskController.tasks.removeAt(i);
      } else {
        i++;
      }
    }
    notifyListeners();
  }

  editEmployee({Employee? emp, String? name, int? department,context}) {
    emp!.name = name;
    Department dep =
        departments.firstWhere((element) => element.id == department);
    emp.department = dep;
    Map<String, dynamic> data = emp.toJson();
    data.remove('user');
    empNetwork.editEmployee(id: emp.id.toString(), data: data);
    int index = employees.indexWhere((element) => element.id == emp.id);
    employees[index] = emp;
    initEmployees(context);
    notifyListeners();
  }


  employeeActivation({required User user, required int index}) {
    employees[index].user = user;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
