import 'package:flutter/material.dart';

class DeviceController extends ChangeNotifier{
String device='Desktop';
  checkPlatform(context){
    if(MediaQuery.of(context).size.width<500){
      device='Mobile';

    }
    else{
      device='Desktop';
    }
  }
}
