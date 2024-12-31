import 'package:flutter/material.dart';
import 'webview_page.dart'; // Import the WebViewPage

class MoviesSection extends StatelessWidget {
  final List<MoviePlatform> platforms = [
    MoviePlatform(
      name: 'Netflix',
      iconAsset: 'assets/moviesImages/netflix.png', // Path to the local image
      url: 'https://www.netflix.com',
    ),
    MoviePlatform(
      name: 'Amazon Prime',
      iconAsset: 'assets/moviesImages/amazonprime.png', // Path to the local image
      url: 'https://www.amazonprime.com/Prime-Video',
    ),
            MoviePlatform(
      name: 'Youtube',
      iconAsset: 'assets/moviesImages/youtube.png', // Path to the local image
      url: 'https://www.youtube.com',
    ),
    MoviePlatform(
      name: 'Hulu',
      iconAsset: 'assets/moviesImages/hulu.png', // Path to the local image
      url: 'https://www.hulu.com',
    ),
    MoviePlatform(
      name: 'Disney+Hotstar',
      iconAsset: 'assets/moviesImages/hotstar.png', // Path to the local image
      url: 'https://www.hotstar.com',
    ),
    
    MoviePlatform(
      name: 'HBO Max',
      iconAsset: 'assets/moviesImages/hbomax.png', // Path to the local image
      url: 'https://www.hbomax.com',
    ),
    MoviePlatform(
      name: 'SonyLive',
      iconAsset: 'assets/moviesImages/sonylive.png', // Path to the local image
      url: 'https://sonylive.com',
    ),
    MoviePlatform(
      name: 'Paramount+',
      iconAsset: 'assets/moviesImages/paramount.png', // Path to the local image
      url: 'https://www.paramountplus.com',
    ),
    MoviePlatform(
      name: 'ZEE5',
      iconAsset: 'assets/moviesImages/zee5.png', // Path to the local image
      url: 'https://www.zee5.com',
    ),
        MoviePlatform(
      name: 'Jio Cinema',
      iconAsset: 'assets/moviesImages/jiocinema.png', // Path to the local image
      url: 'https://www.jiocinema.com',
    ),
            MoviePlatform(
      name: 'Disney+',
      iconAsset: 'assets/moviesImages/disney.png', // Path to the local image
      url: 'https://www.disney+.com',
    ),
            MoviePlatform(
      name: 'CrunchyRoll',
      iconAsset: 'assets/moviesImages/crunchyroll.png', // Path to the local image
      url: 'https://www.crunchyroll.com',
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
  final MoviePlatform platform;

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
                platform.iconAsset, // Use Image.asset for local Images
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


class MoviePlatform {
  final String name;
  final String iconAsset; // Changed from IconData to String for asset path
  final String url;

  MoviePlatform({
    required this.name,
    required this.iconAsset, // Updated parameter
    required this.url,
  });
}


