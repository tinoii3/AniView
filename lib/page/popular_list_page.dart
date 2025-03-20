import 'package:aniview/page/anime_detail_page.dart';
import 'package:aniview/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:aniview/models/anime.dart';

class PopularListPage extends StatelessWidget {
  final List<Anime> animes;

  const PopularListPage({Key? key, required this.animes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003d2e),
        title: const Text(
          'Popular',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ส่วน Search Bar
            Container(
              color: const Color(0xFF003d2e),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF004F3C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  readOnly: true, // ไม่ให้พิมพ์ในหน้านี้
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(animes: animes),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Anime',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 13),
                  ),
                ),
              ),
            ),

            // GridView อยู่ใน Column เดียวกัน
            GridView.builder(
              // สำคัญ: shrinkWrap + ปิดสกอลล์ในตัวเอง
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10.0),
              itemCount: animes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final anime = animes[index];
                final rank = index + 1;

                return Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AnimeDetailPage(
                                anime: anime,
                              ), // ส่งข้อมูล anime
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 200,
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white, width: 1),
                            image: DecorationImage(
                              image: AssetImage(anime.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 160,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.white,
                            child: Text(
                              '$rank',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // แถบเมนูด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF003d2e),
        currentIndex: 2,
        onTap: (index) {
          // ถ้าเป็น 0 ให้ไปหน้า Home
          // ถ้าเป็น 1 ให้ไปหน้า Browse
          // ถ้าเป็น 2 ให้ไปหน้า Popular
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(animes: animes),
              ),
            );
          }
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white, // Set unselected item color to white
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'Popular',
          ),
        ],
      ),
    );
  }
}
