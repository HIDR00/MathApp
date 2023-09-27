import 'package:flutter/material.dart';
import 'package:math/configs/style_configs.dart';

class ResultDialog extends StatefulWidget {
  const ResultDialog({super.key});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text(
        "Chúc mừng! bạn đã \nhọc tốt hơn rồi",
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 265,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.rotate(
              angle: 0.3,
              alignment: AlignmentDirectional(-1, 16),
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: True, width: 2),
                  borderRadius: BorderRadius.all(Radius.elliptical(30, 25)),
                ),
                child: Center(
                    child: Text(
                  "+2%",
                  style: TextStyle(color: True),
                )),
              ),
            ),
            Image(image: AssetImage("assets/images/Group 1709.png")),
            GestureDetector(
              onTap: () {
                
              },
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 60,
                  width: 280,
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
                    "Tuyệt vời",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
