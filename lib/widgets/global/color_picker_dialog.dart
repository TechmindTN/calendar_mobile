import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color currentColor = const Color(0xff443a49);
  Color pickerColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              currentColor = pickerColor;
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffD9D9D9),
              fixedSize: Size(45.w, 7.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))),
          child: Text(
            "Confirm",
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(color: Colors.white)),
          ),
        )
      ],
      content: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: 45.w,
        height: 53.h,
        child: Column(
          children: [
            ColorPicker(
              pickerAreaHeightPercent: 0.5,
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ],
        ),
      ),
    );
  }
}
