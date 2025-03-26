import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AlHadithPage extends StatefulWidget {
  @override
  _AlHadithPageState createState() => _AlHadithPageState();
}

class _AlHadithPageState extends State<AlHadithPage> {
  final List<String> titles = [
    '''1. ความเป็นประชาชาติสายกลาง
    {وَكَذَٰلِكَ جَعَلْنَاكُمْ أُمَّةً وَسَطًا لِّتَكُونُوا شُهَدَاءَ عَلَى النَّاسِ وَيَكُونَ الرَّسُولُ عَلَيْكُمْ شَهِيدًا} (البقرة من آية 143)
    “และในทำนองเดียวกัน เราได้ให้พวกเจ้าทั้งหลายเป็นประชาชาติสายกลาง เพื่อว่าเจ้าทั้งหลายจะได้เป็นสักขีพยานแก่มวลมนุษย์ และศาสนทูต(มูฮัมมัด) ก็จะเป็นสักขีพยานแก่พวกเจ้า”''',
    '''2. ความดี الْخَيْرِيَّة หมายถึงความดีของประชาชาติมุสลิมที่อัลลอฮ์ได้กล่าวถึงในอัลกุรอานว่า :
    “ พวกเจ้านั้น เป็นประชาชาติที่ดียิ่งที่อุบัติขึ้นสำหรับมนุษย์ชาติ โดยที่พวกเจ้าใช้ให้ปฏิบัติสิ่งที่ชอบ และห้ามสิ่งที่มิชอบ และศรัทธามั่นต่ออัลลอฮ์”  (อาลิอิมรอน : 110)''',
    '''3.  ความยุติธรรม الْعَدْل  หมายถึงความยุติธรรมที่มิได้จำกัดอยู่เฉพาะมุสลิมเท่านั้น แต่เป็นสิทธิ์ของมนุษย์ทุกคนที่พึงได้รับ ดังที่อัลลอฮ์ได้ตรัสว่า :
    { يَا أَيُّهَا الَّذِينَ آمَنُوا كُونُوا قَوَّامِينَ لِلَّهِ شُهَدَاءَ بِالْقِسْطِ وَلَا يَجْرِمَنَّكُمْ شَنَآنُ قَوْمٍ عَلَىٰ أَلَّا تَعْدِلُوا اعْدِلُوا هُوَ أَقْرَبُ لِلتَّقْوَىٰ } (المائدة 8)
    “ ผู้ศรัทธาทั้งหลาย ! จงเป็นผู้ปฏิบัติหน้าที่ด้วยดีเพื่ออัลลอฮ์ เป็นพยานด้วยความเที่ยงธรรม และจงอย่าให้การเกลียดชังพวกหนึ่งพวกใด ทำให้พวกเจ้าไม่ยุติธรรม จงยุติธรรมเถิด มันเป็นสิ่งที่ใกล้กับความยำเกรงยิ่งกว่า ”''',
  ];

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
                  'อัลฮะดีษ',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: List.generate(
              titles.length,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(40.0), // Padding ของกล่องข้อความ
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Align(
                            alignment: Alignment.topLeft, // จัดข้อความให้อยู่ด้านบน
                            child: Text(
                              titles[index],
                              style: TextStyle(
                                color: Color(0xFF006400),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.visible, // แสดงข้อความทั้งหมด
                              softWrap: true, // ให้ข้อความแสดงได้ทั้งหมด
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
