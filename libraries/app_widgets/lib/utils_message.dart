import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as Toast;
import 'package:design_system/resources/export_app_res.dart';

import 'buttons/widget_text_button.dart';

void showSnackBar(BuildContext context, String? message) {
  if (message == null || message.isEmpty == true) message = AppText.errorUnknown;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(message)));
}

void showToast(String? message, {Color backgroundColor = Colors.grey}) {
  if (message == null || message.isEmpty == true) message = "-";
  Toast.Fluttertoast.showToast(
      backgroundColor: backgroundColor,
      msg: message,
      toastLength: Toast.Toast.LENGTH_LONG,
      gravity: Toast.ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5);
}

void showFlushbar({
  required BuildContext context,
  required String title,
  Color? color,
  Function? action,
  String? actionTitle,
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50, // Adjust for status bar
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing, vertical: AppDimen.spacingSmall),
          decoration: BoxDecoration(
            color: color ?? Colors.grey,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: AppDimen.spacingNormal),
              Row(
                children: [
                  Expanded(
                      child: Text(title,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white, fontSize: 14))),
                  SizedBox(width: 10),
                  Icon(Icons.info, color: Colors.white),
                ],
              ),
              SizedBox(height: AppDimen.spacingNormal),
              if (actionTitle != null) MyTextButton(actionTitle, () => action?.call())
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Automatically remove the flush bar after 3 seconds
  Future.delayed(Duration(seconds: 4)).then((_) => overlayEntry.remove());
}
