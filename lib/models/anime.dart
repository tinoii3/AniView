import 'package:aniview/widgets/anime_section.dart';
import 'package:flutter/material.dart';

class Anime {
  final String title;
  final String imagePath;

  Anime({required this.title, required this.imagePath});
}

/// Widget หลัก
class AnimeHomePage extends StatefulWidget {
  const AnimeHomePage({Key? key}) : super(key: key);

  @override
  State<AnimeHomePage> createState() => _AnimeHomePageState();
}

class _AnimeHomePageState extends State<AnimeHomePage> {
  int _selectedIndex = 0;

  // ตัวอย่างข้อมูล Popular
  final List<Anime> popularAnimes = [
    Anime(title: 'Tokyo ghoul', imagePath: 'assets/images/TokyoGhoul.jpg'),
    Anime(title: 'Sword Art Online', imagePath: 'assets/images/sao.jpg'),
    Anime(
      title: 'Attack on titan',
      imagePath: 'assets/images/AttackOnTitan.jpg',
    ),
  ];

  // ตัวอย่างข้อมูล Update
  final List<Anime> updateAnimes = [
    Anime(title: 'Dr.stone', imagePath: 'assets/images/DoctorStone.jpg'),
    Anime(title: 'Solo leveling', imagePath: 'assets/images/SoloLeveling.png'),
    Anime(title: 'Sakamoto day', imagePath: 'assets/images/SakamotoDay.png'),
    Anime(
      title: 'SHANGRI-LA FRONTIER',
      imagePath: 'assets/images/Shangfor.png',
    ),
    Anime(
      title: "Kubo Won't Let Me Be Invisible",
      imagePath: 'assets/images/Kubo.jpg',
    ),
    Anime(title: 'Blue Box', imagePath: 'assets/images/BlueBox.jpg'),
    Anime(title: 'Re:ZERO', imagePath: 'assets/images/ReZero.jpg'),
    Anime(
      title: 'Orb: On the Movements of the Earth',
      imagePath: 'assets/images/Earth.jpg',
    ),
  ];

  // ฟังก์ชันเปลี่ยนหน้า (Bottom Navigation)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // แอปบาร์
      appBar: AppBar(
        backgroundColor: const Color(0xFF003d2e),
        title: const Text(
          'AniView',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle:
            false, // Change this to false to move the title to the left
        elevation: 0,
      ),

      // เนื้อหาในหน้า
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ช่องค้นหา
            Container(
              color: const Color(0xFF003d2e),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF004F3C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
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

            // Section Popular
            AnimeSection(
              title: 'Popular',
              animes: popularAnimes.take(3).toList(),
              fullAnimes: popularAnimes,
            ),

            // Section Update
            AnimeSection(
              title: 'Update',
              animes: updateAnimes,
              fullAnimes: updateAnimes,
            ),
          ],
        ),
      ),

      // แถบเมนูด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF003d2e),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
