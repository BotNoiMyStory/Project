import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TajData extends StatefulWidget {
  const TajData({Key? key}) : super(key: key);

  @override
  State<TajData> createState() => _TajDataState();
}

class _TajDataState extends State<TajData> {
  final List<Map<String, dynamic>> rules = [
    {
      'title': 'กฎของ นูนสากิน และ ตันวีน (احكام النون الساكنة والتنوين)',
      'children': [
        {
          'title': 'อิซฮาร์ (إظهار) – อ่านชัดเจน',
          'description':
          'อ่านเสียง "น" หรือ ตันวีน ชัดเจนเมื่ออยู่หน้าตัวอักษร อิซฮาร์ 6 ตัว: ء، هـ، ع، ح، غ، خ',
          'examples': [
            '🔹 مِنْ هَادٍ → มิน ฮาดิน',
            '🔹 فَسَقَىٰهُمْ حَتَّىٰ → ฟะสะกอฮุม หัตตา'
          ]
        },
        {
          'title': 'อิคลาบ (إقلاب) – เปลี่ยนเสียง "น" เป็น "ม"',
          'description':
          'เปลี่ยนเสียง นูนสากิน (نْ) และ ตันวีน เป็นเสียง มีม (م) เมื่ออยู่หน้าตัวอักษร ب',
          'examples': [
            '🔹 مِنْ بَعْدِ → มิม บะอ์ดิ',
            '🔹 سَمِيعٌ بَصِيرٌ → สะมีอุม บะซีรุน'
          ]
        },
        {
          'title': 'อิดกอม – กลืนเสียง',
          'children': [
            {
              'title': 'อิดกอมมีฆุนนะฮ์',
              'description': 'ออกเสียง น ม ว ย พร้อมฆุนนะฮ์',
              'examples': ['✅ มัน ยะกูล', '✅ เยามะอิซิน วุญูฮุน']
            },
            {
              'title': 'อิดกอมไม่มีฆุนนะฮ์',
              'description': 'ออกเสียง ล และ ร โดยไม่มีฆุนนะฮ์',
              'examples': ['✅ มิล ละดุนฮุ', '✅ ฆะฟูรุน รอฮีมุน']
            }
          ]
        },
        {
          'title': 'อิฆฟาอ์ (إخفاء) – ซ่อนเสียง',
          'description':
          'ซ่อนเสียง "น" และ ตันวีน โดยออกเสียงระหว่าง อิซฮาร์ และ อิดกอม เมื่ออยู่หน้าตัวอักษร 15 ตัว',
          'examples': [
            '🔹 مِنْ شَرِّ → มิ้น ชัรริ',
            '🔹 وَلَكِن كَذَّبُوا → วะลากิ้น กัซซะบู'
          ]
        }
      ]
    },
    {
      'title': 'กฎของ มีมสากิน (احكام الميم الساكنة)',
      'children': [
        {
          'title': 'อิซฮาร์ ชัฟาวีย์ (إظهار شفوي) – อ่านชัดเจน',
          'description':
          'อ่าน ม ชัดเจนเมื่ออยู่หน้าตัวอักษรที่ไม่ใช่ ب หรือ م',
          'examples': ['🔹 وَهُمْ فِيهَا → วะฮุม ฟีฮา']
        },
        {
          'title': 'อิดกอม ชัฟาวีย์ (إدغام شفوي) – กลืนเสียงมีม',
          'description': 'กลืนเสียง มْ กับตัวอักษร ม',
          'examples': ['🔹 لَكُمْ مَا → ละกุม มา']
        },
        {
          'title': 'อิฆฟาอ์ ชัฟาวีย์ (إخفاء شفوي) – ซ่อนเสียงมีม',
          'description': 'ซ่อนเสียง ม เมื่ออยู่หน้าตัวอักษร ب',
          'examples': ['🔹 تَرْمِيهِمْ بِحِجَارَةٍ → ตัรมีฮิม บิฮิจาระฮ์']
        }
      ]
    },
    {
      'title': 'กฎของ มัดดฺ (المدّ – การยืดเสียง)',
      'children': [
        {
          'title': 'มัดดฺธรรมดา (المد الطبيعي) – ยืด 2 ฮะรอกะฮ์',
          'examples': ['🔹 قَالَ → กาลา', '🔹 يَقُولُ → ยะกูลู']
        },
        {
          'title':
          'มัดดฺวาญิบ มุตตะซิล (المد الواجب المتصل) – ยืด 4-5 ฮะรอกะฮ์',
          'examples': ['🔹 จ๊าอา → จ๊าอา', '🔹 ซี๊อัต → ซี๊อัต']
        },
        {
          'title':
          'มัดดฺญาอิซ มุนฟะซิล (المد الجائز المنفصل) – ยืด 4-5 ฮะรอกะฮ์',
          'examples': [
            '🔹 ฟี อันฟุซิกุม → ฟี อันฟุซิกุม',
            '🔹 อินนา อันซัลนาฮุ → อินนา อันซัลนาฮุ'
          ]
        },
        {
          'title': 'มัดดฺลาซิม (المد اللازم) – ยืด 6 ฮะรอกะฮ์',
          'examples': [
            '🔹 วะล๊อ ดด๊อลลีน → วะล๊อ ดด๊อลลีน',
            '🔹 อ๊าลล๊าอาน → อ๊าลล๊าอาน'
          ]
        }
      ]
    },
    {
      'title': 'กฎอื่น ๆ ที่สำคัญ',
      'children': [
        {
          'title': 'กันกะละฮ์ (قلقلة) – กระทบเสียง',
          'description': 'เมื่อเจอ ق، ط، ب، ج، د ที่มีสกุน ให้ออกเสียงกระทบ',
          'examples': ['🔹 วะตับ → วะตับ', '🔹 อะฮัด → อะฮัด']
        }
      ]
    }
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
                  'ตัจญวีด',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: ListView(
            children: rules.map((section) {
              return ExpansionTile(
                title: Text(
                  section['title'] ?? '',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                trailing: Icon(MdiIcons.chevronRight, color: Colors.green),
                children: (section['children'] as List).map<Widget>((rule) {
                  return rule.containsKey('children')
                      ? ExpansionTile(
                    title: Text(
                      rule['title'] ?? '',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,
                      color: Colors.white),
                    ),
                    trailing: Icon(MdiIcons.chevronRight, color: Colors.green),
                    children: (rule['children'] as List)
                        .map<Widget>((subRule) {
                      return _buildCard(subRule);
                    }).toList(),
                  )
                      : _buildCard(rule);
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> rule) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(MdiIcons.alphaACircle, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      rule['title'] ?? '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              if (rule['description'] != null) ...[
                SizedBox(height: 8),
                Text(rule['description'], style: TextStyle(fontSize: 16)),
              ],
              if (rule['examples'] != null) ...[
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rule['examples'].map<Widget>((example) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        '- $example',
                        style: TextStyle(fontSize: 16, color: Colors.blue.shade700),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}