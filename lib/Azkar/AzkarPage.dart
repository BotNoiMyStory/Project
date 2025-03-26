import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับโหลดไฟล์ JSON
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'AzkarList.dart';

class AzkarPage extends StatefulWidget {
  @override
  _AzkarPageState createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  List<dynamic> chapters = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/data/azkar.json');
    final data = json.decode(response);
    setState(() {
      chapters = data['data'][0]['azkar'];
    });
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  MdiIcons.arrowLeft,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Expanded(
                child: Text(
                  'บทรำลึกถึงสดุดีถึงอัลลอฮฺยามเช้า-ยามเย็น',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Chulamooc',
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF006400), Color(0xFF228B22)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: chapters.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AzkarList(
                          chapterName: chapter['chapter_name']['th'],
                          azkar: chapter['azkar'],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          chapter['chapter_name']['th'],
                          style: TextStyle(
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
    );
  }
}
