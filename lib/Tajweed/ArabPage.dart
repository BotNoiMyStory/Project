import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Arabpage extends StatefulWidget {
  @override
  _ArabpageState createState() => _ArabpageState();
}

class _ArabpageState extends State<Arabpage> {
  final Map<String, List<String>> sections = {
    'ฐานเกิดที่หนึ่ง': [
      '> ลำคอ خ غ ح ع ه จับไปที่ลำคอ ออกเสียงให้ชัด',
    ],
    'ฐานเกิดที่สอง': [
      '> โคนลิ้น ك กับ ق',
    ],
    'ฐานเกิดที่สาม': [
      '> ช่องลิ้น ض ',
      '> กลางลิ้น ي ش ج ',
      '> ช่องลิ้น ز س ص ',
      '> ปลายลิ้นจรดโคนฟัน ت د ط',
      '> ปลายลิ้นจรดไรฟัน  ث ذ ظ',
      '> ริมฝีปาก ف و และ م ب ',
    ],
    'ฐานเกิดตายตัว': [
      'ได้แก่ ي و ا ออกแสียงบนอากาศออกจากโพรงปากตามหาสระเหมาะสมตามกฎมัตตอบีอี',
      'อลีฟคู่กับฟัตฮะห์  اَ ',
      'ยากัสเราะห์  يِ ',
      'วาวดอมมะห์  وُ',
    ],
    'ฐานเกิดไม่ตายตัว': [
      'ได้แก่  م ن ที่โพรงจมูก',
      'มีสุกูน ْْ  หรือชัดดะห์ ٌ  เสียงขึ้นจมูกอ่านให้ชัดเจน ',
      'ตัวอย่าง',
      'أَمٌَ    إٍنٌَ  หรือ  أَمْ  أَنْ  إِنْ',
      'อิน  อัน  อัม      อินน่า  อัมมา',
    ],
  };

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
                  'ฐานเกิดอักษรภาษาอาหรับ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Google-Font',
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF006400), Color(0xFF228B22)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: sections.entries.map((entry) {
              final title = entry.key;
              final contentLines = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                width: double.infinity,
                child: Card(
                  color: Color(0xFFC8E6C9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006400),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...contentLines.map(
                              (line) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              line,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Arab',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
