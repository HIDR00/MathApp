import 'package:flutter/material.dart';

import '../configs/style_configs.dart';

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({super.key});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        "Khoảng cài đặt không đúng",
        textAlign: TextAlign.center,
      ),
      content: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 60,
          width: 100,
          decoration: BoxDecoration(
            color: Yellow2,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE4C36A),
              )
            ],
            border: Border.all(
              color: stroke,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
              child: Text(
            "<< Chỉnh sửa",
            style: TextStyle(fontSize: 20),
          )),
        ),
      ),
    );
  }
}
