import 'dart:convert';
import 'package:applicationproject/AlHadith/AlHadithPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applicationproject/Exercise/QuranQuizPage.dart';
import '../Exercise/ScorePage.dart';
import '../Tajweed/TajweedPage.dart';
import '../home/HomePage.dart';
import 'Surah/SurahPage.dart';

class QuranPage extends StatefulWidget {
 final String userName; // เพิ่มตัวแปรเก็บค่า userName

 QuranPage({required this.userName}); // แก้ไข Constructor

 @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<dynamic> chapters = [];

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  Future<void> fetchChapters() async {
    try {
      final response = await http.get(
        Uri.parse('https://webmastergame.shop/AppQuran/quran_chapter.php'),
      );
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        setState(() {
          chapters = data['quran']
              .map((chapter) => {
                    "quran_chapter_id": chapter['quran_chapter_id'].toString(),
                    "chapter_name": chapter['quran_data']['chapter_name']['th']
                  })
              .toList();
        });
      } else {
        throw Exception('Failed to load chapters');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  int _selectedIndex = 2; // ตั้งค่าหน้าเริ่มต้นเป็นหน้าอัลกุรอาน

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // ถ้าเลือกหน้าปัจจุบัน จะไม่ทำอะไร
      return;
    }

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
          MaterialPageRoute(builder: (context) => TajweedPage(userName: widget.userName)),
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
                  'อัลกุรอาน',
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
        child: chapters.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () {
                          int chapterId = int.tryParse(
                                  chapters[index]["quran_chapter_id"].toString()) ??
                              0;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SurahPage(
                                QuranchapterId: chapterId,
                                chapterName: chapters[index]["chapter_name"],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: Text(
                                '${chapters[index]["quran_chapter_id"]}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                chapters[index]["chapter_name"],
                                style: const TextStyle(
                                  color: Color(0xFF006400),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
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
