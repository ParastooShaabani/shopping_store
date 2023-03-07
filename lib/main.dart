import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/state_management_get/views/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'آسان مارکت',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Directionality(
          textDirection: TextDirection.ltr,
          child: Welcome(),
        ));
  }
}
