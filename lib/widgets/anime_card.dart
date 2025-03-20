import 'package:flutter/material.dart';
import 'package:aniview/models/anime.dart';
import 'package:aniview/page/anime_detail_page.dart'; // นำเข้า AnimeDetailPage

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final bool showTitle;

  const AnimeCard({Key? key, required this.anime, this.showTitle = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 11),
      child: GestureDetector(
        onTap: () {
          // เมื่อกดที่การ์ดให้ไปหน้า AnimeDetailPage พร้อมข้อมูล anime
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AnimeDetailPage(anime: anime), // ส่งข้อมูล anime
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนรูปภาพ
            Container(
              width: 120,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: AssetImage(anime.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // ชื่ออนิเมะ
            if (showTitle)
              SizedBox(
                width: 100,
                child: Text(
                  anime.title,
                  style: const TextStyle(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
