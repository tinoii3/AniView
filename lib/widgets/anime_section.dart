import 'package:aniview/models/anime.dart';
import 'package:aniview/page/popular_list_page.dart';
import 'package:aniview/page/update_list_page.dart';
import 'package:aniview/widgets/anime_card.dart';
import 'package:flutter/material.dart';

class AnimeSection extends StatelessWidget {
  final String title;
  final List<Anime> animes;
  final List<Anime> fullAnimes;

  const AnimeSection({
    Key? key,
    required this.title,
    required this.animes,
    required this.fullAnimes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // หัวข้อกับ See All
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // ใช้ TextButton แทน Text
              TextButton(
                onPressed: () {
                  // ถ้าเป็น Popular -> ไปหน้า PopularListPage
                  // ถ้าเป็น Update -> ไปหน้า UpdateListPage
                  if (title == 'Popular') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PopularListPage(
                              animes: fullAnimes, // ส่งตัวเต็ม
                            ),
                      ),
                    );
                  } else if (title == 'Update') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => UpdateListPage(
                              animes: fullAnimes, // ส่งตัวเต็ม
                            ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'See All',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        // List แนวนอน
        GridView.builder(
          padding: const EdgeInsets.only(left: 14, right: 2),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: animes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 รูปต่อแถว
            crossAxisSpacing: 0, // ระยะห่างระหว่างการ์ดในแนวนอน
            mainAxisSpacing: 16, // ระยะห่างระหว่างการ์ดในแนวตั้ง
            childAspectRatio: 0.7, // อัตราส่วนกว้าง : สูง (ปรับตามดีไซน์)
          ),
          itemBuilder: (context, index) {
            final anime = animes[index];
            return AnimeCard(anime: anime);
          },
        ),
      ],
    );
  }
}
