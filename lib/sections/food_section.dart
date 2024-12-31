import 'package:flutter/material.dart';
import 'webview_page.dart'; // Import the WebViewPage

class FoodSection extends StatelessWidget {
  final List<FoodPlatform> platforms = [
    FoodPlatform(
      name: 'Swiggy',
      iconAsset: 'assets/foodImages/swiggy.jpg', // Path to the local image
      url: 'https://www.swiggy.com',
    ),
    FoodPlatform(
      name: 'Zepto',
      iconAsset: 'assets/foodImages/zepto.jpg', // Path to the local image
      url: 'https://www.zeptonow.com',
    ),
    FoodPlatform(
      name: 'Zomato',
      iconAsset: 'assets/foodImages/zomato.jpg', // Path to the local image
      url: 'https://www.zomato.com',
    ),
    FoodPlatform(
      name: 'Grubhub',
      iconAsset: 'assets/foodImages/grubhub.jpg', // Path to the local image
      url: 'https://www.grubhub.com',
    ),
    FoodPlatform(
      name: 'EatSure',
      iconAsset: 'assets/foodImages/eatsure.jpg', // Path to the local image
      url: 'https://www.eatsure.com',
    ),
    FoodPlatform(
      name: 'Uber Eats',
      iconAsset: 'assets/foodImages/ubereats.jpg', // Path to the local image
      url: 'https://www.ubereats.com',
    ),
    FoodPlatform(
      name: 'Reliance Retail',
      iconAsset: 'assets/foodImages/relianceretail.jpg', // Path to the local image
      url: 'https://www.relianceretail.com',
    ),
    FoodPlatform(
      name: 'Jio Mart',
      iconAsset: 'assets/foodImages/jiomart.jpg', // Path to the local image
      url: 'https://www.jiomart.com',
    ),
    FoodPlatform(
      name: 'DoorDash',
      iconAsset: 'assets/foodImages/doordash.jpg', // Path to the local image
      url: 'https://www.doordash.com',
    ),
    FoodPlatform(
      name: 'EatClub',
      iconAsset: 'assets/foodImages/eatclub.jpg', // Path to the local image
      url: 'https://www.eatclub.in',
    ),
    FoodPlatform(
      name: 'Dominos',
      iconAsset: 'assets/foodImages/dominos.jpg', // Path to the local image
      url: 'https://www.dominos.co.in',
    ),
    FoodPlatform(
      name: 'Country Delight',
      iconAsset: 'assets/foodImages/countrydelight.jpg', // Path to the local image
      url: 'https://www.countrydelight.in',
    ),
    FoodPlatform(
      name: 'Postmates',
      iconAsset: 'assets/foodImages/postmates.jpg', // Path to the local image
      url: 'https://www.postmates.com',
    ),
    FoodPlatform(
      name: 'Burger Kings',
      iconAsset: 'assets/foodImages/burgerkings.jpg', // Path to the local image
      url: 'https://www.burgerking.in',
    ),
    FoodPlatform(
      name: 'Blinkit',
      iconAsset: 'assets/foodImages/blinkit.jpg', // Path to the local image
      url: 'https://www.blinkit.com',
    ),
    FoodPlatform(
      name: 'KFC',
      iconAsset: 'assets/foodImages/kfc.jpg', // Path to the local image
      url: 'https://www.online.kfc.co.in',
    ),
    FoodPlatform(
      name: 'La pinoz Pizza',
      iconAsset: 'assets/foodImages/lapinoz.jpg', // Path to the local image
      url: 'https://www.lapinozpizza.in',
    ),
    FoodPlatform(
      name: 'Eat24',
      iconAsset: 'assets/foodImages/eat24.jpg', // Path to the local image
      url: 'https://www.eat24.com',
    ),
    FoodPlatform(
      name: 'Pizza Hut',
      iconAsset: 'assets/foodImages/pizzahut.jpg', // Path to the local image
      url: 'https://www.pizzahut.co.in',
    ),
    FoodPlatform(
      name: 'McDonalds',
      iconAsset: 'assets/foodImages/mcdonalds.jpg', // Path to the local image
      url: 'https://www.mcdonalds.com',
    ),
    FoodPlatform(
      name: 'BigBasket',
      iconAsset: 'assets/foodImages/bigbasket.jpg', // Path to the local image
      url: 'https://www.bigbasket.com',
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
  final FoodPlatform platform;

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

class FoodPlatform {
  final String name;
  final String iconAsset;
  final String url;

  FoodPlatform({
    required this.name,
    required this.iconAsset,
    required this.url,
  });
}
