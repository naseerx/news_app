import 'package:flutter/material.dart';
import 'package:fyp/pages/channels_screen.dart';
import 'Home_screen.dart';
import 'bookmark_screen.dart';
import 'cate_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const ChannelsScreen(),
    const BookMarkScreen(),
  ];
  int currentindex=0;
  void onTap(int index){
    setState((){
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: pages[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentindex,
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Categories',
            icon: Icon(Icons.apps_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Channels',
            icon: Icon(Icons.newspaper_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Saved',
            icon: Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}
