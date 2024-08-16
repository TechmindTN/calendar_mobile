import 'package:project_calendar/controllers/calendar_controller.dart';
import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/note_controller.dart';
import 'package:project_calendar/controllers/permatask_controller.dart';
import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/controllers/protask_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/screens/Login/LoginScreen.dart';
import 'package:project_calendar/screens/splash_screen.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'controllers/user_controller.dart';

Future<void> main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
   

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var togo=const LoginScreen();
  SideMenuController sideMenuController=SideMenuController();
 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceController()),
        ChangeNotifierProvider(create: (_) => CalendarController()),
        ChangeNotifierProvider(create: (_) => ProjectController()),
        ChangeNotifierProvider(create: (_) => EmployeesController()),
        ChangeNotifierProvider(create: (_) => TaskController()),
         ChangeNotifierProvider(create: (_) => PermataskController()),
                  ChangeNotifierProvider(create: (_) => ProtaskController()),

        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => NoteController()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
            theme: ThemeClass.lightTheme,
            debugShowCheckedModeBanner: false,
            home:  const SplashScreen()
          );
        }
      ),
    );
  }
}
