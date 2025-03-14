import 'package:flutter/material.dart';
import 'package:aniview/models/anime.dart'; // import model Anime

class AnimeListPage extends StatelessWidget {
  final String title;
  final List<Anime> animes;

  const AnimeListPage({
    Key? key,
    required this.title,
    required this.animes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // แสดงชื่อหมวด
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: animes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
          crossAxisSpacing: 8, 
          mainAxisSpacing: 8, 
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final anime = animes[index];
          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(anime.imagePath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                anime.title,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
