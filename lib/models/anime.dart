import 'dart:math';

import 'package:aniview/page/popular_list_page.dart';
import 'package:aniview/page/search_page.dart';
import 'package:aniview/widgets/anime_section.dart';
import 'package:flutter/material.dart';

class Anime {
  final String title;
  final String imagePath;
  final String description;
  final List<String> genres;
  final String author;
  final String publisher;
  final String firstPublished;
  final String format;
  final String day; // 'Su', 'M', 'Tu', ...

  Anime({
    required this.title,
    required this.imagePath,
    required this.description,
    required this.genres,
    required this.author,
    required this.publisher,
    required this.firstPublished,
    required this.format,
    this.day = '',
  });
}

/// Widget หลัก
class AnimeHomePage extends StatefulWidget {
  const AnimeHomePage({Key? key}) : super(key: key);

  @override
  State<AnimeHomePage> createState() => _AnimeHomePageState();
}

class _AnimeHomePageState extends State<AnimeHomePage> {
  int _selectedIndex = 0;

  List<Anime> get myAnimeList => [...popularAnimes, ...updateAnimes];

  // ตัวอย่างข้อมูล Popular
  final List<Anime> popularAnimes = [
    Anime(
      title: 'Tokyo ghoul',
      imagePath: 'assets/images/TokyoGhoul.jpg',
      description: 'A dark fantasy story about ghouls and the hunt for them.',
      genres: ['Action', 'Horror', 'Supernatural'],
      author: 'Sui Ishida',
      publisher: 'Shueisha',
      firstPublished: '2011',
      format: 'Manga / Anime',
    ),
    Anime(
      title: 'Sword Art Online',
      imagePath: 'assets/images/sao.jpg',
      description: 'A story about players trapped in a virtual reality MMORPG.',
      genres: ['Action', 'Adventure', 'Fantasy'],
      author: 'Rei Kawahara',
      publisher: 'ASCII Media Works',
      firstPublished: '2009',
      format: 'Light Novel / Anime',
    ),
    Anime(
      title: 'Attack on titan',
      imagePath: 'assets/images/AttackOnTitan.jpg',
      description:
          'Humanity fights for survival against giant humanoid creatures.',
      genres: ['Action', 'Adventure', 'Drama'],
      author: 'Hajime Isayama',
      publisher: 'Kodansha',
      firstPublished: '2009',
      format: 'Manga / Anime',
    ),
    Anime(
      title: "JoJo's Bizarre Adventure",
      imagePath: 'assets/images/jojo.jpg',
      description:
          'A multi-generational epic about the Joestar family and their battles.',
      genres: ['Action', 'Adventure', 'Supernatural'],
      author: 'Hirohiko Araki',
      publisher: 'Shueisha',
      firstPublished: '1987',
      format: 'Manga / Anime',
    ),
    Anime(
      title: 'Demon Slayer',
      imagePath: 'assets/images/yaiba.png',
      description:
          'A young boy battles demons after his family is slaughtered.',
      genres: ['Action', 'Fantasy', 'Supernatural'],
      author: 'Koyoharu Gotouge',
      publisher: 'Shueisha',
      firstPublished: '2016',
      format: 'Manga / Anime',
    ),
    Anime(
      title: "Frieren: Beyond Journey's End",
      imagePath: 'assets/images/frieren.jpg',
      description:
          "During their decade-long quest to defeat the Demon King, the members of the hero's party—Himmel himself, the priest Heiter, the dwarf warrior Eisen, and the elven mage Frieren—forge bonds through adventures and battles, creating unforgettable precious memories for most of them.",
      genres: ['Adventure', 'Drama', 'Fantasy'],
      author: 'Yamada Kanehito',
      publisher: 'Shogakukan',
      firstPublished: '2020',
      format: 'Manga / Anime',
    ),
  ];

  // ตัวอย่างข้อมูล Update
  final List<Anime> updateAnimes = [
    Anime(
      title: 'Dr.stone',
      imagePath: 'assets/images/DoctorStone.jpg',
      description:
          'A post-apocalyptic world where humanity is re-creating civilization.',
      genres: ['Sci-Fi', 'Adventure', 'Shounen'],
      author: 'Riichiro Inagaki',
      publisher: 'Shueisha',
      firstPublished: '2017',
      format: 'Manga / Anime',
      day: 'Su',
    ),
    Anime(
      title: 'Solo leveling',
      imagePath: 'assets/images/SoloLeveling.png',
      description:
          'A weak hunter gains immense power and levels up in a dungeon-filled world.',
      genres: ['Action', 'Fantasy', 'Adventure'],
      author: 'Chugong',
      publisher: 'D&C Media',
      firstPublished: '2018',
      format: 'Web Novel / Manhwa',
      day: 'M',
    ),
    Anime(
      title: 'Sakamoto day',
      imagePath: 'assets/images/SakamotoDay.png',
      description:
          'A high school student hides his identity and keeps up with his studies.',
      genres: ['Comedy', 'School', 'Slice of Life'],
      author: 'Nami Sano',
      publisher: 'Shueisha',
      firstPublished: '2020',
      format: 'Manga / Anime',
      day: 'Tu',
    ),
    Anime(
      title: 'SHANGRI-LA FRONTIER',
      imagePath: 'assets/images/Shangfor.png',
      description:
          'A gamer explores a new virtual reality game with a new story.',
      genres: ['Action', 'Adventure', 'Fantasy'],
      author: 'Katarina',
      publisher: 'Kodansha',
      firstPublished: '2020',
      format: 'Light Novel / Manga / Anime',
      day: 'W',
    ),
    Anime(
      title: "Kubo Won't Let Me Be Invisible",
      imagePath: 'assets/images/Kubo.jpg',
      description:
          'A high school student who becomes invisible until a girl notices him.',
      genres: ['Romance', 'Comedy', 'Slice of Life'],
      author: 'Nene Yukimori',
      publisher: 'Shueisha',
      firstPublished: '2020',
      format: 'Manga / Anime',
      day: 'Th',
    ),
    Anime(
      title: 'Blue Box',
      imagePath: 'assets/images/BlueBox.jpg',
      description:
          'A story about a high school student trying to balance his love life and sports.',
      genres: ['Sports', 'Romance', 'Shounen'],
      author: 'Kouji Miura',
      publisher: 'Shueisha',
      firstPublished: '2020',
      format: 'Manga / Anime',
      day: 'F',
    ),
    Anime(
      title: 'Re:ZERO',
      imagePath: 'assets/images/ReZero.jpg',
      description:
          'A young man is transported to a fantasy world where he faces constant death.',
      genres: ['Fantasy', 'Drama', 'Thriller'],
      author: 'Tappei Nagatsuki',
      publisher: 'Kadokawa',
      firstPublished: '2012',
      format: 'Light Novel / Manga / Anime',
      day: 'Sa',
    ),
    Anime(
      title: 'Orb: On the Movements of the Earth',
      imagePath: 'assets/images/Earth.jpg',
      description:
          'A scientific adventure exploring the mysteries of Earth and space.',
      genres: ['Sci-Fi', 'Adventure'],
      author: 'Kazuki Hirata',
      publisher: 'Kodansha',
      firstPublished: '2021',
      format: 'Manga / Anime',
      day: 'Su',
    ),
    Anime(
      title: 'Detective Conan',
      imagePath: 'assets/images/conan.jpg',
      description:
          'Shinichi Kudou, a high school student of astounding talent in detective work, is well known for having solved several challenging cases. One day, when Shinichi spots two suspicious men and decides to follow them, he inadvertently becomes witness to a disturbing illegal activity. Unfortunately, he is caught in the act, so the men dose him with an experimental drug formulated by their criminal organization, leaving him to his death. However, to his own astonishment, Shinichi lives to see another day, but now in the body of a seven-year-old child.',
      genres: ['Adventure', 'Comedy', 'Mystery'],
      author: 'Junichi Iioka',
      publisher: 'Shogakukan',
      firstPublished: '1994',
      format: 'Manga / Anime',
      day: 'M',
    ),
    Anime(
      title: "I'm Getting Married to a Girl I Hate in My Class",
      imagePath: 'assets/images/girl_hate.jpg',
      description:
          "There is only one person that high school student Saito Houjou truly cannot stand—and that is his temperamental classmate, Akane Sakuramori. The two have always been on bad terms; their contrasting views and personalities only lead to endless fighting. However, everything changes when Saito's grandfather and Akane's grandmother arrange a sudden meeting and insist that the two get married!",
      genres: ['Comedy', 'Romance'],
      author: 'Amano Seiju',
      publisher: 'Kadokawa',
      firstPublished: '2021',
      format: 'Manga / Anime',
      day: 'Tu',
    ),
    Anime(
      title: "Unnamed Memory",
      imagePath: 'assets/images/unname.jpg',
      description:
          "Once upon a time in a faraway land, a beautiful witch lived atop a tall tower with no intention of descending. Instead, she awaited the brave knight who would overcome many perils to meet her. Should someone triumph over her many traps, she would grant them any one wish. One day, such a courageous prince did arrive, and he asked her to rid him of the curse preventing him from siring an heir. But the curse of another witch cannot be so easily lifted, and the only way to save his bloodline... is to become his bride?!",
      genres: ['Adventure', 'Fantasy', 'Romance'],
      author: 'Furumiya Kuji ',
      publisher: 'Shōsetsuka ni Narō',
      firstPublished: '2012',
      format: 'Manga / Anime',
      day: 'W',
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
                child: TextField(
                  readOnly: true, // ไม่ให้พิมพ์ในหน้านี้
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(animes: myAnimeList),
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

            // Section Popular
            AnimeSection(
              title: 'Popular',
              animes: popularAnimes.take(3).toList(),
              fullAnimes: myAnimeList,
              popularAnimes: popularAnimes,
              updateAnimes: updateAnimes,
            ),

            // Section Update
            AnimeSection(
              title: 'Update',
              animes: updateAnimes,
              fullAnimes: myAnimeList,
              popularAnimes: popularAnimes,
              updateAnimes: updateAnimes,
            ),
          ],
        ),
      ),

      // แถบเมนูด้านล่าง
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF003d2e),
        currentIndex: _selectedIndex,
        onTap: (index) {
          // ถ้าเป็น 0 ให้ไปหน้า Home
          // ถ้าเป็น 1 ให้ไปหน้า Browse
          // ถ้าเป็น 2 ให้ไปหน้า Popular

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(animes: myAnimeList),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => PopularListPage(
                      animes: popularAnimes,
                      myAnimeList: myAnimeList, // ส่งตัวเต็ม
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
