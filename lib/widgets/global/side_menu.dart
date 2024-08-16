import 'package:project_calendar/screens/Logout/logout_dialog.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MySideMenu extends StatelessWidget {
  final SideMenuController sideMenuController;
  final PageController pageController;
  ThemeClass themeClass = ThemeClass();

  MySideMenu(
      {super.key,
      required this.sideMenuController,
      required this.pageController});
  @override
  Widget build(BuildContext context) {
    List<SideMenuItem> sideItems=[

    SideMenuItem(priority: 0,
    title: "Calendar",
    iconWidget: const Icon(Icons.calendar_month,
    color: Colors.white,
    ),
    onTap: (index, _) {
      sideMenuController.changePage(index);
            pageController.jumpToPage(index);

    },
    ),
    SideMenuItem(priority: 1,
    iconWidget: const Icon(Icons.list,
    color: Colors.white,
    ),
    title: "Projects",
    onTap: (index, _) {
      sideMenuController.changePage(index);
            pageController.jumpToPage(index);

    },
    
    ),
    SideMenuItem(priority: 2,
    onTap: (index, _) {
      pageController.jumpToPage(index);
      sideMenuController.changePage(index);
    },
    title: "Employees",
    iconWidget: const Icon(Icons.people,
    color: Colors.white,
    ),
    
    ),
    // const SideMenuItem(priority: 3,
    // title: "Profile",
   
    // ),
    // const SideMenuItem(priority: 4,
    // title: "Settings",
    
    
    // ),
    SideMenuItem(priority: 5,
    onTap: (index, _) {
      showDialog(context: context, builder: ((context) => const LogoutDialog()));
      
   
    },
    title: "Logout",
    iconWidget: const Icon(Icons.logout,
    color: Colors.white,
    ),
    
    
    ),
  ];
    return SideMenu(
      showToggle: true,
      controller: sideMenuController,
      items: sideItems,
      style: SideMenuStyle(
          displayMode: SideMenuDisplayMode.compact,
          toggleColor: Colors.white,
          backgroundColor: themeClass.secondaryColor,
          selectedTitleTextStyle: const TextStyle(color: Colors.white),
          unselectedTitleTextStyle: const TextStyle(color: Colors.white),
          selectedColor: themeClass.secondaryColor,
          itemOuterPadding: EdgeInsets.zero),
    );
  }
}
