import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../LogInPage.dart';
import '../Quran/QuranPage.dart';
import '../Tajweed/TajweedPage.dart';
import '../home/HomePage.dart';
import 'QuranQuizPage.dart';

class ScorePage extends StatefulWidget {
  final String userName;

  ScorePage({required this.userName});

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int _selectedIndex = 4;
  List<Map<String, String>> history = [];

  @override
  void initState() {
    super.initState();
    _fetchScoreData();
  }

  Future<void> _fetchScoreData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://webmastergame.shop/AppQuran/getattempt.php?username=${widget.userName}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          List<Map<String, String>> tempHistory = (data['data'] as List).map((item) {
            return {
              "quran_name": item['quran_name'].toString(),
              "attempt_date": item['attempt_date'].toString(),
              "attempt_number": item['attempt_number'].toString(),
              "total_score": item['total_score'].toString(),
              "total_questions": item['total_questions'].toString(),
            };
          }).toList();

          // เรียงลำดับตาม attempt_date จากล่าสุดไปเก่าสุด
          tempHistory.sort((a, b) => b["attempt_date"]!.compareTo(a["attempt_date"]!));

          setState(() {
            history = tempHistory;
          });
        } else {
          setState(() {
            history = [];
          });
        }
      } else {
        setState(() {
          history = [];
        });
      }
    } catch (e) {
      setState(() {
        history = [];
      });
    }
  }


  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TajweedPage(userName: widget.userName)),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuranPage(userName: widget.userName)),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuranQuizPage(userName: widget.userName)),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScorePage(userName: widget.userName)),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Group history by Quran name
    Map<String, List<Map<String, String>>> groupedHistory = {};
    for (var entry in history) {
      String quranName = entry['quran_name'] ?? 'Unknown';
      if (groupedHistory.containsKey(quranName)) {
        groupedHistory[quranName]!.add(entry);
      } else {
        groupedHistory[quranName] = [entry];
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'ผลคะแนน',
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.w700,
            fontFamily: 'Google-Font',
            fontSize: 30,
          ),
        ),
        actions: [
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
        backgroundColor: Color(0xFF006400),
        toolbarHeight: 80,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF006400),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05,
                  horizontal: MediaQuery.of(context).size.width * 0.2,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF006400),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'สวัสดี, ${widget.userName}',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF006400),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.yellow, width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'ประวัติการทำแบบฝึกหัด',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow),
                          ),
                        ),
                        SizedBox(height: 8),
                        history.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: groupedHistory.length,
                                itemBuilder: (context, index) {
                                  String quranName =
                                      groupedHistory.keys.elementAt(index);
                                  List<Map<String, String>> entries =
                                      groupedHistory[quranName]!;

                                  return Card(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            'ซูเราะห์: $quranName',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Google-Font',
                                                color: Colors.red),
                                          ),
                                        ),
                                        ...entries.map((entry) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  'วันที่ทำ: ${entry["attempt_date"]}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'จำนวนครั้ง: ${entry["attempt_number"]}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      'คะแนนรวม: ${entry["total_score"]}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      'จำนวนคำถาม: ${entry["total_questions"]}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.amber, // เส้นแบ่ง
                                                thickness: 1, // ความหนาของเส้น
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  );
                                },
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
