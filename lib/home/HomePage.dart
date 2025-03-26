import 'dart:async';
import 'dart:math';
import 'package:applicationproject/AlHadith/AlHadithPage.dart';
import 'package:applicationproject/Azkar/AzkarPage.dart';
import 'package:applicationproject/Dua/DuaPage.dart';
import 'package:applicationproject/Exercise/QuranQuizPage.dart';
import 'package:applicationproject/Exercise/ScorePage.dart';
import 'package:applicationproject/LogInPage.dart';
import 'package:applicationproject/Quran/QuranPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applicationproject/Tajweed/TajweedPage.dart';

class HomePage extends StatefulWidget {
  final String userName;

  HomePage({required this.userName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String greetingMessage;

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'สวัสดีตอนเช้า';
    } else if (hour < 18) {
      return 'สวัสดีตอนบ่าย';
    } else {
      return 'สวัสดีตอนเย็น';
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // กลับไปหน้าหลัก
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userName: widget.userName)),
              (route) => false, // ลบทุกหน้าใน Navigator Stack และเปิดหน้า HomePage
        );
        break;
      case 1:
      // ไปหน้าตัจญวีด
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TajweedPage(userName: widget.userName,)),
        );
        break;
      case 2:
      // ไปหน้าอัลกุรอาน
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuranPage(userName: widget.userName)),
        );
        break;
      case 3:
      // ไปหน้าแบบฝึกหัด
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranQuizPage(userName: widget.userName),
          ),
        );
        break;
      case 4:
      // ไปหน้าแบบฝึกหัด
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScorePage(userName: widget.userName)),
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    greetingMessage = getGreetingMessage();
    // Set up the timer to update the random message every 10 seconds
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 23),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greetingMessage,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Chulamooc',
                        fontSize: 24,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      widget.userName,
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Chulamooc',
                        fontSize: 26,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ออกจากระบบ'),
                        content: Text('คุณต้องการออกจากระบบหรือไม่?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('ยกเลิก'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text('ยืนยัน'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  MdiIcons.logout,
                  color: Colors.yellow,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF006400),
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity, // ขยายให้เต็มหน้าจอ
          height: double.infinity, // ขยายให้เต็มหน้าจอ
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BGH.png'),
              fit: BoxFit.cover, // ปรับภาพให้เต็มพื้นที่
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 320),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlHadithPage()),
                    );
                  },
                  child: Card(
                    elevation: 23,
                    shadowColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    color: Colors.white,
                    margin: EdgeInsets.all(35),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(120.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FlutterIslamicIcons.quran2,
                                size: 50,
                                color: Color(0xFF006400),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "อัลฮะดีษ",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Google-Font',
                                  color: Color(0xFF006400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AzkarPage()),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Color(0xFF006400),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      FlutterIslamicIcons.solidTasbih3,
                                      size: 50,
                                      color: Color(0xFFFFD700),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "อัซการ",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Google-Font',
                                        color: Color(0xFFFFD700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DuaPage()),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Color(0xFF006400),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      FlutterIslamicIcons.tawhid,
                                      size: 50,
                                      color: Color(0xFFFFD700),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "ดุอาร์",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Google-Font',
                                        color: Color(0xFFFFD700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF006400).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.homeOutline),
              label: 'หน้าหลัก',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.bookOpenPageVariantOutline),
              label: 'หลักการอ่านอัลกุรอาน',
            ),
            BottomNavigationBarItem(
              icon: Icon(FlutterIslamicIcons.solidQuran2),
              label: 'อัลกุรอาน',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.bookOpenPageVariantOutline),
              label: 'แบบฝึกหัด',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.scoreboard),
              label: 'ผลคะแนน',
            ),
          ],
          iconSize: 45,
          selectedItemColor: const Color(0xFF006400),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
