
import 'package:hive/hive.dart';

import '../configs/style_configs.dart';
import '../model/number_model.dart';

Future setUp() async {
  Hive.registerAdapter(NumberModelAdapter());
  await Hive.openBox(boxNumbers);
}