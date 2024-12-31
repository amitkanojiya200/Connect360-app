import 'package:flutter/material.dart';
import 'webview_page.dart'; // Import the WebViewPage

class NewsSection extends StatelessWidget {
  final List<NewsPlatform> platforms = [
        NewsPlatform(
      name: 'Dainik Bhaskar',
      iconAsset: 'assets/newsImages/dainik.png', // Path to the local image
      url: 'https://www.bhaskar.com',
    ),
        NewsPlatform(
      name: 'Aal Tak',
      iconAsset: 'assets/newsImages/aajtak.png', // Path to the local image
      url: 'https://www.aajtak.in',
    ),
        NewsPlatform(
      name: 'Google News',
      iconAsset: 'assets/newsImages/googlenews.png', // Path to the local image
      url: 'https://www.news.google.com',
    ),
        NewsPlatform(
      name: 'BBC',
      iconAsset: 'assets/newsImages/bbc.png', // Path to the local image
      url: 'https://www.bbc.com',
    ),
        NewsPlatform(
      name: 'Maharashtra Times',
      iconAsset: 'assets/newsImages/maharashtratimes.png', // Path to the local image
      url: 'https://www.news.marathi.indiatimes.com',
    ),
        NewsPlatform(
      name: 'Esakal',
      iconAsset: 'assets/newsImages/esakal.png', // Path to the local image
      url: 'https://www.esakal.com',
    ),
        NewsPlatform(
      name: 'CNN',
      iconAsset: 'assets/newsImages/cnn.png', // Path to the local image
      url: 'https://www.cnn.com',
    ),
        NewsPlatform(
      name: 'Al Jazeera',
      iconAsset: 'assets/newsImages/aljazeera.png', // Path to the local image
      url: 'https://www.aljazeera.com',
    ),
        NewsPlatform(
      name: 'Way2News',
      iconAsset: 'assets/newsImages/way2news.png', // Path to the local image
      url: 'https://www.way2news.com',
    ),
        NewsPlatform(
      name: 'The Guardian',
      iconAsset: 'assets/newsImages/gaurdian.png', // Path to the local image
      url: 'https://www.theguardian.com',
    ),
        NewsPlatform(
      name: 'Times Now Navbharat',
      iconAsset: 'assets/newsImages/navbharat.png', // Path to the local image
      url: 'https://www.timesnowhindi.com',
    ),
        NewsPlatform(
      name: 'Reuters',
      iconAsset: 'assets/newsImages/reuters.png', // Path to the local image
      url: 'https://www.reuters.com',
    ),
        NewsPlatform(
      name: 'Public App',
      iconAsset: 'assets/newsImages/publicapp.png', // Path to the local image
      url: 'https://www.public.app',
    ),
        NewsPlatform(
      name: 'Bloomberg',
      iconAsset: 'assets/newsImages/bloomberg.png', // Path to the local image
      url: 'https://www.bloomberg.com',
    ),
        NewsPlatform(
      name: 'Lokmat',
      iconAsset: 'assets/newsImages/lokmat.png', // Path to the local image
      url: 'https://www.lokmat.com',
    ),
        NewsPlatform(
      name: 'The New York Times',
      iconAsset: 'assets/newsImages/nytimes.png', // Path to the local image
      url: 'https://www.nytimes.com',
    ),
        NewsPlatform(
      name: 'Washington Post',
      iconAsset: 'assets/newsImages/washington.png', // Path to the local image
      url: 'https://www.washingtonpost.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: platforms.length,
      itemBuilder: (context, index) {
        final platform = platforms[index];
        return PlatformBlock(platform: platform);
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) {
      return 4; // Tablet or large screen
    } else if (width > 400) {
      return 3; // Small tablet or large phone
    } else {
      return 2; // Phone
    }
  }
}

class PlatformBlock extends StatelessWidget {
  final NewsPlatform platform;

  PlatformBlock({required this.platform});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(url: platform.url),
          ),
        );
      },
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                platform.iconAsset, // Use Image.asset for local images
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 12.0),
              Text(
                platform.name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class NewsPlatform {
  final String name;
  final String iconAsset;
  final String url;

  NewsPlatform({
    required this.name,
    required this.iconAsset,
    required this.url,
  });
}
