import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _obscureText = true;  // สถานะการแสดงหรือซ่อนรหัสผ่าน
  final String _apiUrl = 'https://webmastergame.shop/AppQuran/signup.php';

  // ฟังก์ชันการตรวจสอบข้อมูล
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'กรุณากรอกชื่อผู้ใช้';
    if (value.length > 100) return 'ชื่อผู้ใช้ห้ามเกิน 100 ตัวอักษร';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'กรุณากรอกอีเมล';
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'กรุณากรอกอีเมลที่ถูกต้อง';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'กรุณากรอกรหัสผ่าน';
    if (value.length < 8) return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร';
    return null;
  }

  String? _validateDob(String? value) {
    if (value == null || value.isEmpty) return 'กรุณากรอกวันเดือนปีเกิด';
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) return 'กรุณากรอกวันเดือนปีเกิดในรูปแบบ DD/MM/YYYY';
    return null;
  }

  // ฟังก์ชันการสมัครสมาชิก
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(_apiUrl),
          body: {
            'username': _userNameController.text.trim(),
            'email': _emailController.text.trim(),
            'password': _passwordController.text,
            'dob': _dobController.text,
          },
        );

        if (response.statusCode == 200) {
          final signUpData = json.decode(response.body);
          if (signUpData['success'] == true) {
            _showSuccessDialog(); // แสดงหน้าต่างแจ้งเตือน
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(signUpData['error'] ?? 'เกิดข้อผิดพลาด')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('เกิดข้อผิดพลาดในการเชื่อมต่อ')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ข้อผิดพลาด: ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('สมัครสมาชิกสำเร็จ'),
          content: Text('คุณได้สมัครสมาชิกเรียบร้อยแล้ว'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
                Navigator.pop(context); // ย้อนกลับไปหน้า Login
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF006400),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: kToolbarHeight),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(MdiIcons.arrowLeft, color: Colors.white, size: 40),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Text(
                  'Al-Quran',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Google-Font',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                _buildTextField('ชื่อผู้ใช้', _userNameController, _validateUsername),
                SizedBox(height: 16),
                _buildTextField('อีเมล', _emailController, _validateEmail),
                SizedBox(height: 16),
                _buildPasswordField(),  // ฟังก์ชันการสร้างฟิลด์รหัสผ่าน
                SizedBox(height: 16),
                _buildTextField('วัน/เดือน/ปีเกิด (DD/MM/YYYY)', _dobController, _validateDob),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('สมัครสมาชิก'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    fixedSize: Size(250, 60),
                    textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Chulamooc'),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันการสร้าง TextField ทั่วไป
  Widget _buildTextField(String label, TextEditingController controller, String? Function(String?) validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            hintText: 'กรุณากรอก$label',
            hintStyle: TextStyle(color: Colors.grey),
            errorStyle: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // ฟังก์ชันการสร้างฟิลด์รหัสผ่าน
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('รหัสผ่านภาษาอังกฤษกับตัวเลขเพียง 8 ตัว', style: TextStyle(fontSize: 18, color: Colors.white)),
        TextFormField(
          controller: _passwordController,
          validator: _validatePassword,
          obscureText: _obscureText,  // ควบคุมการซ่อนหรือแสดงรหัสผ่าน
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            hintText: 'กรุณากรอกรหัสผ่าน',
            hintStyle: TextStyle(color: Colors.grey),
            errorStyle: TextStyle(fontSize: 16),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? MdiIcons.eyeOff : MdiIcons.eye,  // เปลี่ยนไอคอนเปิดตาปิดตา
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;  // สลับสถานะการเปิด/ปิดตาของรหัสผ่าน
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
