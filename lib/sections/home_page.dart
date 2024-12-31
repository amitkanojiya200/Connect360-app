// import 'package:flutter/material.dart';
// import '/auth/login_page.dart'; // Import your login page

// class OnboardingPage extends StatefulWidget {
//   @override
//   _OnboardingPageState createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             children: [
//               _buildPageContent(
//                 title: "Amit Ka Project",
//                 description: "This is a project that offers various sections like Movies, Shopping, News, and more.",
//                 imageAsset: 'assets/onboarding1.png',
//               ),
//               _buildPageContent(
//                 title: "Explore Sections",
//                 description: "Discover different sections including Movies, Shopping, News, Food, and Travel.",
//                 imageAsset: 'assets/onboarding2.png',
//               ),
//               _buildPageContent(
//                 title: "Welcome!",
//                 description: "We are excited to have you. Explore the app and enjoy your experience.",
//                 imageAsset: 'assets/onboarding3.png',
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: _currentPage != 2
//                 ? TextButton(
//                     onPressed: () {
//                       _pageController.jumpToPage(2); // Skip to the last page
//                     },
//                     child: Text("Skip"),
//                   )
//                 : Container(),
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: _currentPage != 2
//                 ? TextButton(
//                     onPressed: () {
//                       _pageController.nextPage(
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     },
//                     child: Text("Next"),
//                   )
//                 : ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to login page
//                       );
//                     },
//                     child: Text("Continue"),
//                   ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: MediaQuery.of(context).size.width / 2 - 40,
//             child: Row(
//               children: List.generate(
//                 3,
//                 (index) => _buildPageIndicator(index == _currentPage),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPageContent({required String title, required String description, required String imageAsset}) {
//     return Padding(
//       padding: const EdgeInsets.all(40.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(imageAsset, height: 250),
//           SizedBox(height: 40),
//           Text(
//             title,
//             style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20),
//           Text(
//             description,
//             style: TextStyle(fontSize: 16),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPageIndicator(bool isCurrentPage) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 150),
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 8.0,
//       width: isCurrentPage ? 24.0 : 16.0,
//       decoration: BoxDecoration(
//         color: isCurrentPage ? Colors.blue : Colors.grey,
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
// }
