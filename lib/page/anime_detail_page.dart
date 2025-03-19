import 'package:flutter/material.dart';
import 'package:aniview/models/anime.dart';  // นำเข้า Anime model

class AnimeDetailPage extends StatelessWidget {
  final Anime anime;  // ตัวแปรเพื่อเก็บข้อมูลอนิเมะ

  const AnimeDetailPage({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003d2e),
        title: Text(anime.title),  // แสดงชื่ออนิเมะใน AppBar
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // เพิ่ม SingleChildScrollView เพื่อให้สามารถเลื่อนหน้าได้
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // แสดงภาพของอนิเมะ (ขนาดสี่เหลี่ยมกลางจอ, ขอบมน, มีกรอบ)
              Center(
                child: Container(
                  width: 200,  // กำหนดความกว้าง
                  height: 250,  // กำหนดความสูง
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),  // ขอบมน
                    border: Border.all(color: Colors.white , width: 1),  // กรอบรอบภาพ
                    image: DecorationImage(
                      image: AssetImage(anime.imagePath),
                      fit: BoxFit.cover,  // ให้ภาพเต็มกรอบ
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // เพิ่มกรอบรอบข้อมูลตั้งแต่ Title ถึง Format
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 7,  right: 80, left: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // แสดงชื่ออนิเมะ
                    Text(
                      'Title: ${anime.title}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // แสดงประเภทของอนิเมะ
                    Text(
                      'Genres: ${anime.genres.join(', ')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    // แสดงผู้แต่ง
                    Text(
                      'Publisher: ${anime.publisher}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    // แสดงปีที่เริ่มเผยแพร่
                    Text(
                      'First Published: ${anime.firstPublished}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    // แสดงรูปแบบ (Manga, Anime, ฯลฯ)
                    Text(
                      'Format: ${anime.format}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // เพิ่มกรอบรอบคำอธิบาย
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // แสดงเรื่องย่อ
                    Text(
                      'Description:',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      anime.description ?? 'No description available.',
                      style: const TextStyle(fontSize: 16, height: 1.4),  // ลดระยะห่างบรรทัด
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
