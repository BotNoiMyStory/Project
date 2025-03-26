import 'package:applicationproject/LogInPage.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  void initState() {
    super.initState();
    // ตั้งเวลา 5 วินาทีเพื่อเปลี่ยนหน้า
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(), // เรียกหน้าถัดไป
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Color(0xFF006400), // พื้นหลังสีเขียวเข้ม
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 150.0), // ขยับรูปขึ้นไปเล็กน้อย
              child: Image.asset(
                'assets/images/2.png', // Path ของรูปภาพ
                width: size.width * 0.5, // ปรับขนาดรูปภาพให้เป็น 50% ของความกว้างหน้าจอ
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'AL QURAN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Google-Font'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
