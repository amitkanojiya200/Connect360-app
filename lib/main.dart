// import 'package:amit_ka_project_hai_naya_wala_1/sections/redirect_page.dart';
import 'package:amit_ka_project_hai_naya_wala_1/splash_screen.dart';
import 'package:flutter/material.dart';
import 'sections/movies_section.dart';
import 'sections/news_section.dart';
import 'sections/food_section.dart';
import 'sections/travel_section.dart';
import 'sections/shopping_section.dart';
import 'sections/user_info_page.dart';
import 'sections/download_section.dart'; // Create a new SearchSection widget
import 'auth/login_page.dart';
import 'sections/search_page.dart'; //Search_page.dart file
import './sections/onBordingPage.dart';
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:image_gallery_saver/image_gallery_saver.dart'; // For saving videos to the gallery
// import 'package:youtube_extractor/youtube_extractor.dart'; // For extracting YouTube video info

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect 360'),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildMainSection(),
          SearchPage(),
          VideoDownloader(),
          UserInfoPage(
            username: "CR",
            email: "crkaemail@gmail.com",
            password: "CR@420",
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: Colors.blue),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.screen_search_desktop_outlined,
                color: Colors.purpleAccent),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download_outlined, color: Colors.green),
            label: 'Download',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'User Info',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildMainSection() {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 5,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'Shopping'),
              Tab(text: 'News'),
              Tab(text: 'Food'),
              Tab(text: 'Travel'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MoviesSection(),
            ShoppingSection(),
            NewsSection(),
            FoodSection(),
            TravelSection(),
          ],
        ),
      ),
    );
  }
}
