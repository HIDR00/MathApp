import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:provider/provider.dart';

import '../configs/style_configs.dart';

class XoaTienTrinh extends StatefulWidget {
  const XoaTienTrinh({super.key});

  @override
  State<XoaTienTrinh> createState() => _XoaTienTrinhState();
}

class _XoaTienTrinhState extends State<XoaTienTrinh> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        "Bạn có chắc muốn xóa dữ liệu \n học tập của bạn?",
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
                        },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                              border: Border.all(color: stroke),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                  child: Center(
                          child: Text(
                                  "Hủy bỏ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                )),
                              ),
                      ),
          ),
          GestureDetector(
              onTap: () {
                      context.read<PhepTinh>().xoaTIenTrinh();
                      Navigator.pop(context);
                        },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                              border: Border.all(color: stroke),
                              borderRadius: BorderRadius.circular(15),
                              color: Yellow2),
                  child: Center(
                          child: Text(
                                  "Được chứ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                )),
                              ),
                      ),
          ),
        ],
      ),
    );
  }
}