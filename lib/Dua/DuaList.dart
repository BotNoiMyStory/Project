import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DuaList extends StatefulWidget {
  final List<dynamic> duas;

  DuaList({required this.duas});

  @override
  _DuaListState createState() => _DuaListState();
}

class _DuaListState extends State<DuaList> {
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
                  'ดุอาร์ใช้ในชีวิตประจำวัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Chulamooc',
                    fontSize: 24,
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
      body: ListView.builder(
        itemCount: widget.duas.length,
        itemBuilder: (context, index) {
          final dua = widget.duas[index];
          // กำหนดสีพื้นหลังและข้อความ
          Color backgroundColor = index.isEven
              ? Color(0xFFE8F5E9) // สีพื้นหลังอ่อนสำหรับรายการคู่
              : Color(0xFFC8E6C9); // สีพื้นหลังเข้มสำหรับรายการคี่
          Color textColor = index.isEven ? Colors.black : Colors.green; // กำหนดสีข้อความ

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              color: backgroundColor, // สีพื้นหลังของแต่ละรายการ
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Text(
                    '${index + 1}', // หมายเลขระบุหน้าชื่อ
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Chulamooc'
                    ),
                  ),
                ),
                title: Text(
                  dua['name']['th'], // แสดงเฉพาะ 'th' จาก 'name'
                  style: TextStyle(
                      color: textColor, // สีของข้อความ
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Chulamooc'
                  ),
                ),
                onTap: () {
                  // เปิดหน้ารายละเอียดดุอาร์
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        constraints: BoxConstraints(
                          maxHeight: 300,
                          minWidth: 350, // กำหนดความกว้างสูงสุด
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dua['name']['th'],
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'อาหรับ: ${dua['about']['text_ar']}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'แปลไทย: ${dua['about']['text_th']}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Expanded(
                              child: Container(), // ใช้เพื่อดันปุ่ม "ปิด" ไปที่ด้านล่างสุด
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('ปิด'),
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
        },
      ),
    );
  }
}
