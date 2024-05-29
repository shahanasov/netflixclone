import 'package:flutter/material.dart';
import 'package:netflix/screen/download.dart';
import 'package:netflix/screen/home.dart';
import 'package:netflix/screen/search.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
   int selectedIndex = 0;

   List<Widget> pages=<Widget> [
    const HomePage(),
    const Center(child: Icon(Icons.live_tv)),
    const SearchPage(),
    const DownloadPage(),
   ];
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.live_tv), label: 'Live tv'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.download_done_outlined), label: 'Download'),
          ]),
          body: pages.elementAt(selectedIndex),
    );
  }
}
