import 'package:aniview/page/popular_list_page.dart';
import 'package:flutter/material.dart';
import 'package:aniview/models/anime.dart';
import 'package:aniview/page/anime_detail_page.dart'; // ถ้าจะลิงค์ไปหน้า detail
import 'package:shared_preferences/shared_preferences.dart'; // ถ้าจะเก็บ recentSearch ถาวร

class SearchPage extends StatefulWidget {
  final List<Anime> animes; // ลิสต์อนิเมะทั้งหมด
  late final List<Anime> popularAnimes; // อนิเมะยอดนิยม

  SearchPage({Key? key, required this.animes}) : super(key: key) {
    popularAnimes = animes.where((anime) => anime.day.isEmpty).toList();
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ตัวแปรสำหรับควบคุม TextField
  final TextEditingController _searchController = TextEditingController();

  // รายการผลลัพธ์หลังกรอง
  late List<Anime> _filteredAnimes;

  // รายการ recent search (string ของคำค้น)
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    // เริ่มต้น _filteredAnimes เป็น animes ทั้งหมด หรือเป็น [] ก็ได้
    _filteredAnimes = widget.animes;

    // โหลด recentSearch จาก SharedPreferences (ถ้าต้องการเก็บถาวร)
    _loadRecentSearches();
  }

  // โหลดจาก SharedPreferences
  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    // ดึง List<String> จาก prefs; ถ้าไม่มีให้เป็น []
    final searches = prefs.getStringList('recentSearches') ?? [];
    setState(() {
      _recentSearches = searches;
    });
  }

  // เซฟลง SharedPreferences
  Future<void> _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentSearches', _recentSearches);
  }

  // ฟังก์ชันกรอง
  void _filterAnimes(String query) {
    if (query.isEmpty) {
      // ถ้าค้นว่างเปล่า ให้แสดงทั้งหมด
      setState(() {
        _filteredAnimes = widget.animes;
      });
    } else {
      final filtered =
          widget.animes.where((anime) {
            // 1) เช็ค title
            final titleMatch = anime.title.toLowerCase().contains(
              query.toLowerCase(),
            );

            // 2) เช็ค genre (เป็น List<String>)
            // ตัวอย่าง: เช็คว่าใน genre ใด ๆ มีคำว่า query ไหม
            final genreMatch = anime.genres.any(
              (g) => g.toLowerCase().contains(query.toLowerCase()),
            );

            // จะ return true ถ้า titleMatch หรือ genreMatch
            return titleMatch || genreMatch;
          }).toList();

      setState(() {
        _filteredAnimes = filtered;
      });
    }
  }

  // เมื่อผู้ใช้กด Enter หรือปุ่มค้นหา
  void _onSearchSubmitted(String query) {
    // 1) บันทึกคำค้นลง recentSearches
    if (query.isNotEmpty) {
      // ถ้าไม่อยากซ้ำ ให้ remove ก่อน add
      _recentSearches.remove(query);
      _recentSearches.insert(0, query); // เอาไว้บนสุด
      // จำกัดจำนวน recentSearches สัก 10?
      if (_recentSearches.length > 10) {
        _recentSearches.removeLast();
      }
      _saveRecentSearches(); // บันทึกลง SharedPreferences
    }

    // 2) กรองลิสต์
    _filterAnimes(query);
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Container(
              color: const Color(0xFF003d2e),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF004F3C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search Anime',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 13),
                  ),
                  onChanged: (value) {
                    // ถ้าต้องการ realtime filter, เรียก filterAnimes
                    _filterAnimes(value);
                  },
                  onSubmitted: (value) {
                    // เมื่อกดปุ่ม Enter บนคีย์บอร์ด
                    _onSearchSubmitted(value);
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // หมวดหมู่ (Action, Sci-Fi, Comedy, Romance) เหมือนเดิม
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _CategoryChip(
                  label: 'Action',
                  onTap: () {
                    _searchController.text = 'Action';
                    _onSearchSubmitted('Action');
                  },
                ),
                _CategoryChip(
                  label: 'Sci-Fi',
                  onTap: () {
                    _searchController.text = 'Sci-Fi';
                    _onSearchSubmitted('Sci-Fi');
                  },
                ),
                _CategoryChip(
                  label: 'Comedy',
                  onTap: () {
                    _searchController.text = 'Comedy';
                    _onSearchSubmitted('Comedy');
                  },
                ),
                _CategoryChip(
                  label: 'Romance',
                  onTap: () {
                    _searchController.text = 'Romance';
                    _onSearchSubmitted('Romance');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Recent Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Animes List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // ปุ่ม Clear All
                  // TextButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _recentSearches.clear();
                  //     });
                  //     _saveRecentSearches();
                  //   },
                  //   child: const Text('Clear All'),
                  // ),
                ],
              ),
            ),

            // const SizedBox(height: 8),

            // // แสดงรายการ recentSearches
            // if (_recentSearches.isEmpty) const Text('No recent search.'),
            // for (var query in _recentSearches)
            //   ListTile(
            //     title: Text(query),
            //     onTap: () {
            //       _searchController.text = query;
            //       _onSearchSubmitted(query);
            //     },
            //   ),
            const SizedBox(height: 16),

            // แสดงผลลัพธ์การค้นหา
            // ถ้าต้องการ Layout สวย ๆ อาจใช้ GridView.builder + shrinkWrap เหมือน popularListPage
            // ที่นี่จะทำง่าย ๆ เป็น ListView.builder ก็ได้
            if (_filteredAnimes.isEmpty)
              const Text('No results found.')
            else
              // ใช้ shrinkWrap เพื่อไม่ conflict กับ SingleChildScrollView
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredAnimes.length,
                itemBuilder: (context, index) {
                  final anime = _filteredAnimes[index];
                  return ListTile(
                    leading: Image.asset(
                      anime.imagePath,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(anime.title),
                    subtitle: Text(anime.genres.join(', ')),
                    onTap: () {
                      // ไปหน้า detail
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimeDetailPage(anime: anime),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),

      // BottomNavigationBar เหมือนเดิม (ถ้าต้องการ)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // บอกว่าอยู่ tab ที่ 1
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
                      animes: widget.popularAnimes,
                      myAnimeList: widget.animes, // ส่งตัวเต็ม
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

class _CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap; // เพิ่ม callback เมื่อกด

  const _CategoryChip({Key? key, required this.label, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // เมื่อกดที่ chip
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label),
      ),
    );
  }
}
