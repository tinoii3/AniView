import 'package:aniview/page/anime_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:aniview/models/anime.dart';
import 'package:aniview/page/popular_list_page.dart';

class UpdateListPage extends StatelessWidget {
  final List<Anime> animes;

  const UpdateListPage({Key? key, required this.animes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7, // 7 วัน
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Su'),
              Tab(text: 'M'),
              Tab(text: 'Tu'),
              Tab(text: 'W'),
              Tab(text: 'Th'),
              Tab(text: 'F'),
              Tab(text: 'Sa'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // กรองอนิเมะให้เหลือเฉพาะวันนั้น ๆ
            _buildGridView(_filterByDay(animes, 'Su')),
            _buildGridView(_filterByDay(animes, 'M')),
            _buildGridView(_filterByDay(animes, 'Tu')),
            _buildGridView(_filterByDay(animes, 'W')),
            _buildGridView(_filterByDay(animes, 'Th')),
            _buildGridView(_filterByDay(animes, 'F')),
            _buildGridView(_filterByDay(animes, 'Sa')),
          ],
        ),

        // BottomNavigationBar
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF003d2e),
          currentIndex: 0, // ใส่ 0 เพราะถือว่าเป็นหน้า Update (สมมติ)
          onTap: (index) {
            // ถ้าเป็น 0 -> กลับหน้า Home
            // ถ้าเป็น 1 -> ไปหน้า Browse
            // ถ้าเป็น 2 -> ไปหน้า Popular
            if (index == 0) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            } else if (index == 1) {
              Navigator.pushNamed(context, '/browse');
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PopularListPage(
                        animes: animes, // ส่งตัวเต็ม
                      ),
                ),
              );
            }
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          iconSize: 30,
          showSelectedLabels: false,
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
      ),
    );
  }

  /// ฟังก์ชันสำหรับสร้าง GridView (รูปแบบ Container ขนาด 200x400)
  Widget _buildGridView(List<Anime> data) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // หรือ 3 ได้ตามชอบ
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final anime = data[index];
        return Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          AnimeDetailPage(anime: anime), // ส่งข้อมูล anime
                ),
              );
            },
            child: Container(
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
          ),
        );
      },
    );
  }

  /// ฟังก์ชันกรองรายการ Anime ให้เหลือเฉพาะ day
  List<Anime> _filterByDay(List<Anime> allAnimes, String day) {
    return allAnimes.where((anime) => anime.day == day).toList();
  }
}
