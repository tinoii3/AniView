import 'package:aniview/models/anime.dart';
import 'package:aniview/page/popular_list_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List<Anime> animes;

  const SearchPage({Key? key, required this.animes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ตัวอย่างโครงสร้าง UI ตามรูป
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // หรือจะทำ AppBar เป็นสีเขียวเหมือนรูปก็ได้
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar ด้านบน
            Container(
              color: const Color(0xFF003d2e),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF004F3C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ), // Set text color to white
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

            const SizedBox(height: 16),

            // หมวดหมู่ (Action, Sci-Fi, Comedy, Romance)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _CategoryChip(label: 'Action'),
                _CategoryChip(label: 'Sci-Fi'),
                _CategoryChip(label: 'Comedy'),
                _CategoryChip(label: 'Romance'),
              ],
            ),

            const SizedBox(height: 16),

            // Recent Search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Recent Search',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // ถ้ามีปุ่ม Clear All ก็ใส่ตรงนี้
              ],
            ),
            const SizedBox(height: 8),

            // ตัวอย่าง 2 รายการ
            _RecentSearchItem(
              title: 'Sakamoto day',
              genres: 'Action, Comedy',
              status: 'Currently Airing',
              imagePath: 'assets/images/SakamotoDay.png', // ตัวอย่าง
            ),
            _RecentSearchItem(
              title: 'JoJo',
              genres: 'Action',
              status: 'Finished Airing',
              imagePath: 'assets/images/jojo.jpg', // ตัวอย่าง
            ),
          ],
        ),
      ),

      // แถบเมนูด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF003d2e),
        currentIndex: 1,
        onTap: (index) {
          // ถ้าเป็น 0 ให้ไปหน้า Home
          // ถ้าเป็น 1 ให้ไปหน้า Browse
          // ถ้าเป็น 2 ให้ไปหน้า Popular

          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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

// ตัวอย่าง Widget แท็บหมวดหมู่
class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label),
    );
  }
}

// ตัวอย่าง Widget รายการ Recent Search
class _RecentSearchItem extends StatelessWidget {
  final String title;
  final String genres;
  final String status;
  final String imagePath;

  const _RecentSearchItem({
    Key? key,
    required this.title,
    required this.genres,
    required this.status,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // รูปภาพ
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // ข้อความ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Genres: $genres'),
                Text('Status: $status'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
