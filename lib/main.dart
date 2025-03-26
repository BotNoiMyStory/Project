import 'package:applicationproject/LogInPage.dart';
import 'package:applicationproject/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:applicationproject/home/Page.dart' as MyPage;


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true, // ปรับเป็น true เพื่อแก้ปัญหาคอนเทนต์ซ้อน
        body: PageView(
          children: <Widget>[
            MyPage.Page(),
            LoginPage(),
            SignUpPage()//
          ],
        ),
      ),
    );
  }
}