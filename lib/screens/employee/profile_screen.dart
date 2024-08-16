// ignore_for_file: use_build_context_synchronously

import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ThemeClass themeClass = ThemeClass();
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names

  late EmployeesController empController;
  late UserController userController;

  @override
  void initState() {
    empController = Provider.of<EmployeesController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {

    super.didChangeDependencies();
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 15.w,
                child: Icon(Icons.person,
                size: 15.w,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h,),
        ProfileRow(txt:"Username",value:userController.currentUser.username!),
        ProfileRow(txt:"Name",value:userController.currentEmployee.name!),
        ProfileRow(txt:"Department",value:userController.currentEmployee.department!.name!),
        SizedBox(
          height: 2.h,
        ),
        Center(
          child: InkWell(
            onTap: (){
              userController.logout(context);
            },
            child: Container(
              // color: Colors.red,
              decoration: BoxDecoration(
                border: Border.all(color: themeClass.primaryColor,
                
                ),
                borderRadius: BorderRadius.circular(4)
              ),
              width: 84.w,
              height: 6.h,
              child: Center(
                child: Text("Logout",
                style: TextStyle(
                  color: themeClass.primaryColor,
                  fontSize: 16
                ),
                ),
              ),
            ),
          ),
        )
        // ProfileRow(txt:"Name",value:userController.currentEmployee.!)
      ]),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
   required this.txt, required this.value,
  });

 
  final String txt;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:32.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(txt,
          style: const TextStyle(fontSize: 18),
          ),
          Text(value,
          style: const TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}
