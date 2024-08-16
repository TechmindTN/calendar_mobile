import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProjectDetailsDialog extends StatefulWidget {
  final int index;

  const ProjectDetailsDialog({
    super.key,
    required this.index,
  });
  @override
  // ignore: no_logic_in_create_state
  State<ProjectDetailsDialog> createState() =>
      _ProjectDetailsDialogState(index: index);
}

class _ProjectDetailsDialogState extends State<ProjectDetailsDialog> {
  final int index;
  ThemeClass themeClass = ThemeClass();
  late ProjectController proController;

  _ProjectDetailsDialogState({required this.index});

  @override
  void didChangeDependencies() {
    proController = Provider.of<ProjectController>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
          backgroundColor: themeClass.backgroundColor,
          title: Container(
            decoration: BoxDecoration(
                color: themeClass.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            height: 5.h,

            child: Padding(
              padding: EdgeInsets.only(left: 1.5.w, top: 1.h),
              child: SelectableText(proController.projects[index].name!,
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 1.h),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: themeClass.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            // padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            width: 70.w,
            height: 45.h,
            child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProjectRow( index: index,txt:"Title",value:proController.projects[index].name!),
                      ProjectRow( index: index,txt:"Duration",value:"${proController.projects[index].duration!} ${proController.projects[index].durationType!.unit!}"),
                      ProjectRow( index: index,txt:"Starting Date",value:"${proController.projects[index].startingDate!.year}-${proController.projects[index].startingDate!.month}-${proController.projects[index].startingDate!.day}"),
                      ProjectRow( index: index,txt:"Deadline",value:"${proController.projects[index].deadline!.year}-${proController.projects[index].deadline!.month}-${proController.projects[index].deadline!.day}"),
                      ProjectColor( index: index,txt:"Color",value:proController.projects[index].color!),
                      ProjectDesc( index: index,txt:"Description",value:proController.projects[index].description!),
                   
                    ],
                  ),
                ),
          )),
    );
  }
}


class ProjectDesc extends StatelessWidget {
  const ProjectDesc({
    super.key,
    required this.index, required this.value, required this.txt,
  });

  final int index;
  final String value;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 8,horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(txt,
          style: const TextStyle(
            fontSize: 18,
            // color: Colors.grey[800]
          ),
          ),
          SizedBox(height: 1.h,),
          SelectableText(value,
          style: const TextStyle(
            fontSize: 18,
            // color: Colors.grey[800]
          ),),
        ],
      ),
    );
  }
}
class ProjectRow extends StatelessWidget {
  const ProjectRow({
    super.key,
    required this.index, required this.value, required this.txt,
  });

  final int index;
  final String value;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(txt,
          style: const TextStyle(
            fontSize: 18,
            // color: Colors.grey[800]
          ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth:35.w ),
            child: SelectableText(value,
            // textDirection: TextDecoration.,
            
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 18,
              // color: Colors.grey[800]
            ),),
          ),
        ],
      ),
    );
  }
}


class ProjectColor extends StatelessWidget {
  const ProjectColor({
    super.key,
    required this.index, required this.value, required this.txt,
  });

  final int index;
  final String value;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(txt,
          style: const TextStyle(
            fontSize: 18,
            // color: Colors.grey[800]
          ),
          ),
          Container(
            width: 18.w,
            height: 3.5.h,
            decoration: BoxDecoration(
              border: Border.all(color: ThemeClass().primaryColor,width: 4),
              borderRadius: BorderRadius.circular(4),
              color:  Color(int.parse(value, radix: 16)),
            ),
          )
        ],
      ),
    );
  }
}