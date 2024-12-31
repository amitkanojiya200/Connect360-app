import 'package:flutter/material.dart';
import '/auth/login_page.dart'; // Import your login page
import '/auth/SignUp_page.dart'; // Import your register page

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue, // Set blue background for all pages
          ),
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPageContent(
                title: "Welcome",
                description:
                    "This is a project that offers various sections like Movies, Shopping, News, and more.",
                imageAsset: 'assets/onbordingImages/page1.png',
              ),
              _buildPageContent(
                title: "Explore Sections",
                description:
                    "Discover different sections including Movies, Shopping, News, Food, and Travel.",
                imageAsset: 'assets/onbordingImages/page3.png',
              ),
              _buildPageContent(
                title: "Connect 360!",
                description:
                    "We are excited to have you. Explore the app and enjoy your experience.",
                imageAsset: 'assets/onbordingImages/page2.png',
              ),
              _buildSignUpPageContent(), // This is the new last page with SignUp and LogIn options.
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: _currentPage != 3
                ? TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(3); // Skip to the last page
                    },
                    child: Text("Skip"),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: _currentPage != 3
                ? TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("Next"),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: Row(
              children: List.generate(
                4, // Updated from 3 to 4 as we added a new page
                (index) => _buildPageIndicator(index == _currentPage),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent({
    required String title,
    required String description,
    required String imageAsset,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAsset, height: 250),
          SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Updated last page content with Sign Up and Log In
  Widget _buildSignUpPageContent() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Let's get Started!!",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Image.asset('assets/onbordingImages/page2.png', height: 250),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // Navigate to SignUp Page when "Sign Up" is clicked
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Blue background color
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increased button size
              textStyle: TextStyle(fontSize: 18), // Button text size
            ),
            child: Text("Sign Up"),
          ),
          SizedBox(height: 20),
          Text(
            "Already have an account?",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              // Navigate to Login Page when "Log In" is clicked
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text("Log In"),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isCurrentPage ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.grey, // Changed to white for visibility
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
