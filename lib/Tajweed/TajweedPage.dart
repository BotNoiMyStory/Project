import 'package:applicationproject/Tajweed/ArabPage.dart';
import 'package:applicationproject/Tajweed/TajData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../Exercise/QuranQuizPage.dart';
import '../Exercise/ScorePage.dart';
import '../Quran/QuranPage.dart';
import '../home/HomePage.dart';

class TajweedPage extends StatefulWidget {
  final String userName; // เพิ่มตัวแปรเก็บค่า userName

  TajweedPage({required this.userName}); // แก้ไข Constructor

  @override
  _TajweedPageState createState() => _TajweedPageState();
}

class _TajweedPageState extends State<TajweedPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userName: widget.userName)),
              (route) => false, // ลบทุกหน้าใน Navigator Stack และเปิดหน้า HomePage
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TajweedPage(userName: widget.userName)), // ใช้ค่า userName
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuranPage(userName: widget.userName)),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranQuizPage(userName: widget.userName), // ใช้ค่า userName
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScorePage(userName: widget.userName)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 23),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'หลักการอ่านคัมภีร์อัลกุรอาน',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Chulamooc',
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFF006400),
        toolbarHeight: 80,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF006400), Color(0xFF228B22)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  _buildMenuItem(
                    icon: MdiIcons.volumeHigh,
                    label: 'ฐานเกิดอักษรภาษาอาหรับ',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Arabpage()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: FlutterIslamicIcons.quran2,
                    label: 'ตัจญวีด',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TajData()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
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

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.green.shade800,
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
