// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: const AnimeUpdateScreen(),
//     );
//   }
// }

// class AnimeUpdateScreen extends StatefulWidget {
//   const AnimeUpdateScreen({super.key});

//   @override
//   State<AnimeUpdateScreen> createState() => _AnimeUpdateScreenState();
// }

// class _AnimeUpdateScreenState extends State<AnimeUpdateScreen> {
//   int selectedIndex = 0; // Index ของวันในสัปดาห์ที่เลือก
//   final List<String> days = ["Su", "M", "Tu", "W", "Th", "F", "Sa"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[900],
//       appBar: AppBar(
//         title: const Text(
//           "Update",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.green[900],
//       ),
//       body: Column(
//         children: [
//           // ช่อง Search
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: "Search Anime",
//                 hintStyle: TextStyle(color: Colors.white70),
//                 prefixIcon: const Icon(Icons.search, color: Colors.white),
//                 filled: true,
//                 fillColor: Colors.green[700],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),

//           // ปุ่มเลือกวันในสัปดาห์
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: List.generate(days.length, (index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: ChoiceChip(
//                     label: Text(days[index]),
//                     selected: selectedIndex == index,
//                     onSelected: (bool selected) {
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                     },
//                     selectedColor: Colors.green[700],
//                     backgroundColor: Colors.green[900],
//                     labelStyle: TextStyle(
//                       color:
//                           selectedIndex == index
//                               ? Colors.white
//                               : Colors.grey[300],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),

//           // รายการแสดงอนิเมะ
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(8.0),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.7,
//               ),
//               itemCount: animeImages.length,
//               itemBuilder: (context, index) {
//                 return AnimeCard(imagePath: animeImages[index]);
//               },
//             ),
//           ),
//         ],
//       ),

//       // แถบนำทางด้านล่าง 3 อัน
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ""),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search, size: 30),
//             label: "",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite, size: 30),
//             label: "",
//           ),
//         ],
//         backgroundColor: Colors.green[900],
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey[400],
//       ),
//     );
//   }
// }

// final List<String> animeImages = [
//   "assets/images/SakamotoDay.png",
//   "assets/images/SoloLeveling.png",
//   "assets/images/DoctorStone.jpg",
//   "assets/images/AttackOnTitan.jpg",
// ];

// // สำหรับแสดงการ์ดอนิเมะ
// class AnimeCard extends StatelessWidget {
//   final String imagePath;
//   const AnimeCard({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Image.asset(imagePath, fit: BoxFit.cover),
//     );
//   }
// }
