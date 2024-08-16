// ignore_for_file: use_build_context_synchronously

import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/screens/calendar/calendar_screen.dart';
import 'package:project_calendar/screens/employee/profile_screen.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/global/appbar_widget.dart';
import '../project/project_list_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  PageController pageController = PageController();
  late DeviceController deviceController;

  SideMenuController sideMenuController = SideMenuController();
  late EmployeesController employeesController;
  late TaskController taskController;
  late ProjectController proController;
   late ProjectController companyController;
     late UserController userController;
     List<Widget> pages=[ const ProjectListScreen(),
        const CalendarScreen(),
        const ProfileScreen()];

@override
void initState() {
  deviceController=Provider.of<DeviceController>(context,listen: false);
       employeesController=Provider.of<EmployeesController>(context,listen: false);
    userController=Provider.of<UserController>(context,listen: false);
     
    taskController=Provider.of<TaskController>(context,listen: false);
    taskController.isLoading=true;
        proController=Provider.of<ProjectController>(context,listen: false);
        

  super.initState();
}

@override
  Future<void> didChangeDependencies() async {
    
   await employeesController.initEmployees(context);
   await employeesController.getDepartments(context);
         await proController.getProjects();
          taskController.getTasks(context).then((value) {
            // taskController.isLoading=true;
        // taskController.getMyMultiCurrentWeekTasks(context);
  //         sideMenuController.addListener((index) {
  //   pageController.jumpToPage(2);
  // });
          });
    super.didChangeDependencies();
  }
  int currentIndex=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(userController,context),
        body: pages[currentIndex],
        bottomNavigationBar: BottomAppBar(
          
          child: BottomNavigationBar(

            // selectedItemColor: themec,
            currentIndex: currentIndex,
            onTap: (value) {
                  // pageController.jumpToPage(value);
                  setState(() {
                     currentIndex=value;
                  });
                 

            },
            items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list_alt),label: "Projects",),
                   BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label: "Calendar"),
                   BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          ]),
        ),
        );
  }
}
