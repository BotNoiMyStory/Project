import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SurahPage extends StatefulWidget {
  final int QuranchapterId;
  final String chapterName;

  SurahPage({super.key, required this.QuranchapterId, required this.chapterName});

  @override
  _SurahPageState createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Verse> verses = [];
  int? currentVersePlaying;
  bool isPlayingAll = false;
  int currentIndex = 0;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAudio(String url, int verseNumber) async {
    await _audioPlayer.stop();
    await _audioPlayer.setSourceUrl(url);
    await _audioPlayer.play(UrlSource(url));
    setState(() => currentVersePlaying = verseNumber);

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() => currentVersePlaying = null);
    });
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      currentVersePlaying = null;
      isPlayingAll = false;
      currentIndex = 0;
    });
  }

  Future<void> _playAllVerses() async {
    if (verses.isEmpty) return;

    setState(() {
      isPlayingAll = true;
      currentIndex = 0;
    });

    for (int i = 0; i < verses.length; i++) {
      if (!isPlayingAll) break;

      await _playSingleVerse(i);
    }

    setState(() {
      isPlayingAll = false;
      currentIndex = 0;
    });
  }

  Future<void> _playSingleVerse(int index) async {
    if (!isPlayingAll || index >= verses.length) return;

    final verse = verses[index];
    setState(() {
      currentVersePlaying = verse.verseNumber;
      currentIndex = index;
    });

    await _audioPlayer.setSourceUrl(verse.audioUrl);
    await _audioPlayer.play(UrlSource(verse.audioUrl));
    await Future.delayed(Duration(seconds: 1));

    await _audioPlayer.onPlayerComplete.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // เปลี่ยนสีพื้นหลังเป็นสีเขียว
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 23),
          child: Row(children: [
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
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.chapterName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Google-Font',
                  fontSize: 30,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ]),
        ),
        backgroundColor: Color(0xFF006400),
        toolbarHeight: 80,
      ),
      body: FutureBuilder<Quran>(
        future: fetchQuranData(widget.QuranchapterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final Quran surah = snapshot.data!;
          verses = surah.verses;
          return ListView(
            padding: EdgeInsets.all(16),
            children: surah.verses.map((verse) {
              bool isPlaying = currentVersePlaying == verse.verseNumber;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isPlaying ? Colors.yellow[200] : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            verse.textTh,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            verse.textAr,
                            style: TextStyle(
                              fontSize: 20,
                              color: isPlaying ? Colors.red : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _playAudio(verse.audioUrl, verse.verseNumber),
                        child: Icon(
                          isPlaying ? MdiIcons.pause : MdiIcons.play,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: isPlaying ? _stopAudio : null,
                        child: Icon(
                          MdiIcons.stop,
                          color: isPlaying ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: isPlayingAll ? null : _playAllVerses,
            child: Icon(MdiIcons.play),
            backgroundColor: isPlayingAll ? Colors.grey : Colors.green,
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _stopAudio,
            child: Icon(MdiIcons.stop),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class Quran {
  final int chapterId;
  final List<Verse> verses;

  Quran({required this.chapterId, required this.verses});

  factory Quran.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> audioMap = json['audio'] ?? {};
    return Quran(
      chapterId: json['quran_chapter_id'],
      verses: (json['quran_data']?['verses'] as List? ?? []).map((verse) {
        int verseNum = verse['verse_number'];
        String audioKey = 'audio${verseNum + 1}';
        String audioUrl = audioMap[audioKey] ?? '';
        return Verse.fromJson(verse, audioUrl);
      }).toList(),
    );
  }
}

class Verse {
  final int verseNumber;
  final String textAr;
  final String textTh;
  final String audioUrl;

  Verse({
    required this.verseNumber,
    required this.textAr,
    required this.textTh,
    required this.audioUrl,
  });

  factory Verse.fromJson(Map<String, dynamic> json, String audioUrl) {
    return Verse(
      verseNumber: json['verse_number'],
      textAr: json['text_ar'] ?? '',
      textTh: json['text_th'] ?? '',
      audioUrl: audioUrl,
    );
  }
}

Future<Quran> fetchQuranData(int chapterId) async {
  final response = await http.get(
    Uri.parse('https://webmastergame.shop/AppQuran/quran_chapter_id.php?quran_chapter_id=$chapterId'),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    return Quran.fromJson(data['quran']);
  } else {
    throw Exception('Failed to load Quran data');
  }
}
