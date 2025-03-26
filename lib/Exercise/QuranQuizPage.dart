import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../Quran/QuranPage.dart';
import '../Tajweed/TajweedPage.dart';
import '../home/HomePage.dart';
import 'QuizPage.dart';
import 'ScorePage.dart';

class QuranQuizPage extends StatefulWidget {
  final String userName;

  // Constructor that requires userName
  QuranQuizPage({required this.userName});

  @override
  _QuranQuizPageState createState() => _QuranQuizPageState();
}

class _QuranQuizPageState extends State<QuranQuizPage> {
  List<String> quranNames = [];

  @override
  void initState() {
    super.initState();
    fetchQuranNames();
  }

  Future<void> fetchQuranNames() async {
    final url = Uri.parse('https://webmastergame.shop/AppQuran/quranquizall.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        quranNames = data.map((item) => item['quran_name'].toString()).toList();
      });
    } else {
      print('Failed to load data');
    }
  }

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

    Widget nextPage;
    switch (index) {
      case 0:
      // กลับไปหน้าหลัก
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userName: widget.userName)),
              (route) => false, // ลบทุกหน้าใน Navigator Stack และเปิดหน้า HomePage
        );
        return;
      case 1:
        nextPage = TajweedPage(userName: widget.userName); // Access userName here
        break;
      case 2:
        nextPage = QuranPage(userName: widget.userName); // Access userName here
        break;
      case 3:
        return;
      case 4:
        nextPage = ScorePage(userName: widget.userName); // Access userName here
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
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
                  'แบบฝึกหัดอัลกุรอาน',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Google-Font',
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
        child: quranNames.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: quranNames.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${index + 1}. ",
                        style: TextStyle(
                          color: Color(0xFF006400),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Google-Font',
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: quranNames[index],
                        style: TextStyle(
                          color: Color(0xFF006400),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Google-Font',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(
                        quranName: quranNames[index],
                        userName: widget.userName, // Send userName to QuizPage
                      ),
                    ),
                  );
                },
              ),
            );
          },
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
