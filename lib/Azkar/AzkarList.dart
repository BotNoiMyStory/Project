import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AzkarList extends StatelessWidget {
  final String chapterName;
  final List<dynamic> azkar;

  AzkarList({required this.chapterName, required this.azkar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
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
            SizedBox(width: 10),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    FlutterIslamicIcons.quran,
                    color: Colors.yellow, // ปรับสีของไอคอนให้เด่นชัด
                  ),
                  SizedBox(width: 10),
                  Text(
                    chapterName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF006400),
        toolbarHeight: 80,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: azkar.length,
        itemBuilder: (context, index) {
          final azkarItem = azkar[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // แสดงชื่อบทใน name
                    Row(
                      children: [
                        Icon(
                          FlutterIslamicIcons.takbir,
                          color: Color(0xFF006400),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            azkarItem['name']['th'],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006400),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // แสดง title_ar
                    Text(
                      azkarItem['about']['title_ar'] ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    // แสดง title_th
                    Text(
                      azkarItem['about']['title_th'] ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    // แสดง text_ar
                    Text(
                      azkarItem['about']['text_ar'] ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    // แสดง text_th
                    Text(
                      azkarItem['about']['text_th'] ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey[400],
                      thickness: 1.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
