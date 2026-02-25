import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/voucher/data/repository/voucher_repository.dart';
import 'features/voucher/presentation/screens/voucher_screen.dart';

void main() {
  Get.put(VoucherRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: VoucherScreen(),
    );
  }
}
