// ignore_for_file: file_names

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/utils/theme.dart';
// import 'package:project_calendar/widgets/global/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

    late DeviceController deviceController;

  late UserController userController;
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Future<void> didChangeDependencies() async {
        deviceController.checkPlatform(context);

    super.didChangeDependencies();
  }

  @override
   initState() {
    
                deviceController=Provider.of<DeviceController>(context,listen: false);
               userController=Provider.of<UserController>(context,listen: false);

        // taskController.isLoading=true;
        
        

    super.initState();
  }

  ThemeClass themeClass = ThemeClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeClass.secondaryColor,
      // appBar: MyAppBar(),adm
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          width: (deviceController.device == "Desktop") ? 25.w : 80.w,
          height: 60.h,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    color: themeClass.primaryColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0))),
                height: 10.h,
                child: Center(
                    child: Text(
                  'Log in to your account',
                  style: TextStyle(
                      fontSize:
                          (deviceController.device == "Desktop") ? 30 : 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
              SizedBox(
                width: (deviceController.device == "Desktop") ? 20.w : 60.w,
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35, bottom: 10),
                        child: Text(
                          "Login:",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeClass.primaryColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                        width: (deviceController.device == "Desktop")
                            ? 20.w
                            : 60.w,
                        child: TextFormField(
                          onFieldSubmitted: ((newValue) {
                            if ((loginController.text == '') ||
                                (passwordController.text == '')) {
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error!',
                                  message: 'Enter correct login and password.',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            } else {
                              userController.mobileLogin(loginController.text,
                                  passwordController.text, context);
                            }
                          }),
                          controller: loginController,
                          decoration: InputDecoration(
                            hintText: 'Login..',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: themeClass.primaryColor),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Text(
                          'Password:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeClass.primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                        width: (deviceController.device == "Desktop")
                            ? 20.w
                            : 60.w,
                        child: TextFormField(
                          onFieldSubmitted: ((newValue) {
                            if ((loginController.text == '') ||
                                  (passwordController.text == '')) {
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Error!',
                                    message: 'Enter correct login and password.',
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              } else {
                                userController.mobileLogin(loginController.text, passwordController.text,context);
                              }
                          }),
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password..',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: themeClass.primaryColor),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 2.0),
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              color: themeClass.primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 15.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: themeClass.primaryColor,
                                fixedSize: Size(
                                    (deviceController.device == "Desktop")
                                        ? 20.w
                                        : 60.w,
                                    7.h),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            onPressed: () {
                              if ((loginController.text == '') ||
                                  (passwordController.text == '')) {
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Error!',
                                    message:
                                        'Enter correct login and password.',
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              } else {
                                userController.mobileLogin(loginController.text, passwordController.text,context);
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ),
                      // Center(
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         side: BorderSide(color: themeClass.primaryColor),
                      //         backgroundColor: Colors.white,
                      //         fixedSize: Size(
                      //             (deviceController.device == "Desktop")
                      //                 ? 20.w
                      //                 : 60.w,
                      //             7.h),
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(5.0))),
                      //     onPressed: () {},
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           'Sign in with Google  ',
                      //           style:
                      //               TextStyle(color: themeClass.primaryColor),
                      //         ),
                      //         Image.asset('Google__G__Logo.svg.png',
                      //             width: 2.w, height: 7.h)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
