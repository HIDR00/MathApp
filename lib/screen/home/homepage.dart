import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math/screen/home/homepageScreen.dart';
import 'package:provider/provider.dart';

import '../../configs/style_configs.dart';
import '../../model/number_model.dart';
import '../../provider/phepTinh_State.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box boxNumber = Hive.box(boxNumbers);
  bool isFetching = false;
  @override
  fetch(){
    var data = boxNumber.get('data');
    if (data ==  null) {
      _fetchData(); 
    } else {
      print("Data already available, don't fetch");
      _getData();
    }
  }
  void initState() {
    super.initState();
    fetch();
  }
  Future<void> _fetchData() async {
    setState(() {
      isFetching = true; // Bắt đầu tải dữ liệu
    });

    try {
      await context.read<PhepTinh>().fetch(); // Tải dữ liệu
    } catch (error) {
      print("Error fetching data: $error"); // Xử lý lỗi nếu có
    } finally {
      setState(() {
        isFetching = false; // Kết thúc tải dữ liệu, cho phép cập nhật giao diện
      });
      print("done");
      // Sau khi tải xong dữ liệu, gọi getData()
    }
  }
  Future<void> _getData() async{
    await context.read<PhepTinh>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PhepTinh, bool>(
      selector: (ctx, state) => state.phepTinh,
      builder: (ctx, value, _) {
        if (isFetching) {
          return CircularProgressIndicator(); // Hiển thị tiến trình tải dữ liệu
        } else {
          return HomePageScreen(phepTinh: value); // Hiển thị giao diện người dùng sau khi dữ liệu đã sẵn sàng
        }
      },
    );
  }
}