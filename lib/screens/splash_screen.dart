import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserController userController;

  @override
  void initState() {
    userController=Provider.of<UserController>(context,listen: false);
    
    super.initState();
  }
  @override
  Future<void> didChangeDependencies() async {
    await userController.checkLogin(context);
    super.didChangeDependencies();
  }
  ThemeClass themeClass=ThemeClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeClass.backgroundColor,
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month,
            size: 120,
            color: themeClass.primaryColor,
            ),
            SizedBox(height: 1.h,),
            Text('Smart Calendar',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 40,
              color: themeClass.primaryColor
      
            ),
            )
          ],
        )
        // Image.asset('')
      ),
    );

  }
}