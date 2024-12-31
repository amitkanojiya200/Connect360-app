// import 'package:flutter/material.dart';

// class SearchSection extends StatefulWidget {
//   @override
//   _SearchSectionState createState() => _SearchSectionState();
// }

// class _SearchSectionState extends State<SearchSection> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchResult = '';

//   void _performSearch() {
//     // This is where you would typically make an API call to a search engine
//     // For demo purposes, we're setting a mock response.
//     setState(() {
//       _searchResult =
//           "Results for '${_searchController.text}':\n\n- Result 1\n- Result 2\n- Result 3";
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your query',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: _performSearch,
//                 ),
//               ),
//               onSubmitted: (query) => _performSearch(),
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   _searchResult.isNotEmpty
//                       ? _searchResult
//                       : 'Enter a query to see results',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:flutter/services.dart';

// class YTVideoDownloader extends StatefulWidget {
//   @override
//   _YTVideoDownloaderState createState() => _YTVideoDownloaderState();
// }

// class _YTVideoDownloaderState extends State<YTVideoDownloader> {
//   TextEditingController _controller = TextEditingController();
//   bool _downloading = false;
//   String _status = "";

//   @override
//   void initState() {
//     super.initState();
//     _askPermission();
//   }

//   // Function to ask for storage permission
//   void _askPermission() async {
//     if (await Permission.storage.request().isGranted) {
//       print("Storage permission granted");
//     } else {
//       print("Storage permission denied");
//     }
//   }

//   // Function to download video
//   Future<void> _downloadVideo(String videoId) async {
//     setState(() {
//       _downloading = true;
//       _status = "Downloading video...";
//     });

//     try {
//       var yt = YoutubeExplode();
//       var video = await yt.videos.get(videoId);
//       var manifest = await yt.videos.streamsClient.getManifest(videoId);
//       var streamInfo = manifest.muxed.withHighestBitrate();

//       // Get the directory to store video
//       var dir = await getTemporaryDirectory();
//       var filePath = '${dir.path}/${video.title}.mp4';
//       var file = File(filePath);

//       var stream = yt.videos.streamsClient.get(streamInfo);
//       var fileStream = file.openWrite();
//       await stream.pipe(fileStream);
//       await fileStream.flush();
//       await fileStream.close();

//       // Save video to gallery using image_gallery_saver
//       final videoBytes = await file.readAsBytes();
//       final result = await ImageGallerySaver.saveFile(file.path);

//       if (result != null && result["isSuccess"]) {
//         setState(() {
//           _status = "Video saved to gallery";
//         });
//       } else {
//         setState(() {
//           _status = "Failed to save video to gallery";
//         });
//       }

//       yt.close();
//     } catch (e) {
//       setState(() {
//         _status = "Error: $e";
//       });
//     } finally {
//       setState(() {
//         _downloading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("YouTube Video Downloader"),
//         centerTitle: true,
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Text field for video ID input
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 labelText: "Enter YouTube Video ID",
//                 border: OutlineInputBorder(),
//                 filled: true,
//                 fillColor: Colors.white,
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.redAccent, width: 2),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey, width: 1),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // Download button
//             _downloading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: () {
//                       if (_controller.text.isNotEmpty) {
//                         _downloadVideo(_controller.text);
//                       } else {
//                         setState(() {
//                           _status = "Please enter a valid video ID";
//                         });
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.redAccent,
//                       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                       textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     child: Text("Download Video"),
//                   ),
//             SizedBox(height: 20),
//             // Status text
//             Text(
//               _status,
//               style: TextStyle(fontSize: 16, color: _status.contains("Error") ? Colors.red : Colors.green),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.grey[200],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert'; // For handling JSON from API responses

class VideoDownloader extends StatefulWidget {
  @override
  _VideoDownloaderState createState() => _VideoDownloaderState();
}

class _VideoDownloaderState extends State<VideoDownloader> {
  TextEditingController _controller = TextEditingController();
  bool _downloading = false;
  String _status = "";
  String _platform = "YouTube";

  @override
  void initState() {
    super.initState();
    _askPermission();
  }

  // Function to ask for storage permission
  void _askPermission() async {
    if (await Permission.storage.request().isGranted) {
      print("Storage permission granted");
    } else {
      print("Storage permission denied");
    }
  }

  // Download YouTube video using youtube_explode_dart
  Future<void> _downloadYouTubeVideo(String videoId) async {
    setState(() {
      _downloading = true;
      _status = "Downloading YouTube video...";
    });

    try {
      var yt = YoutubeExplode();
      var video = await yt.videos.get(videoId);
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var streamInfo = manifest.muxed.withHighestBitrate();

      // Get the directory to store video
      var dir = await getTemporaryDirectory();
      var filePath = '${dir.path}/${video.title}.mp4';
      var file = File(filePath);

      var stream = yt.videos.streamsClient.get(streamInfo);
      var fileStream = file.openWrite();
      await stream.pipe(fileStream);
      await fileStream.flush();
      await fileStream.close();

      // Save video to gallery using image_gallery_saver
      final videoBytes = await file.readAsBytes();
      final result = await ImageGallerySaver.saveFile(file.path);

      if (result != null && result["isSuccess"]) {
        setState(() {
          _status = "YouTube video saved to gallery";
        });
      } else {
        setState(() {
          _status = "Failed to save YouTube video";
        });
      }

      yt.close();
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    } finally {
      setState(() {
        _downloading = false;
      });
    }
  }

  //! Download Instagram video using API (RapidAPI or other similar service)
  Future<void> _downloadInstagramVideo(String videoUrl) async {
    setState(() {
      _downloading = true;
      _status = "Downloading Instagram video...";
    });

    try {
      // Step 1: Validate and extract video ID from the Instagram URL
      String? videoId = _extractInstagramVideoId(videoUrl);

      if (videoId == null) {
        setState(() {
          _status = "Invalid Instagram URL.";
        });
        return;
      }

      // Step 2: Use the video ID to make the API request
      final apiUrl =
          "https://instagram-scraper-api3.p.rapidapi.com/highlight_media?highlight_id=$videoId";

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'x-rapidapi-key':
              '5734288482mshfbe31ab50e8cc18p18a8eejsn76c3714319ac', // Your API key
          'x-rapidapi-host': 'instagram-scraper-api3.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        // Assuming the API response contains the key 'video' for the video download URL
        var videoDownloadUrl = jsonResponse['video'];

        if (videoDownloadUrl != null) {
          await _downloadVideoFromUrl(videoDownloadUrl, "Instagram");
          setState(() {
            _status = "Video downloaded successfully!";
          });
        } else {
          setState(() {
            _status = "No video found for the provided Instagram URL.";
          });
        }
      } else {
        setState(() {
          _status =
              "Failed to fetch Instagram video URL: ${response.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    } finally {
      setState(() {
        _downloading = false;
      });
    }
  }

// Helper function to extract Instagram video ID from the URL
  String? _extractInstagramVideoId(String url) {
    // Normalize the URL to make sure we have a valid Instagram post link
    if (!url.startsWith("https://www.instagram.com/p/")) {
      return null; // Return null if the URL doesn't match the expected pattern
    }

    // Extract the video ID after '/p/' using a simpler approach
    try {
      var uri = Uri.parse(url);
      List<String> segments = uri.pathSegments;
      if (segments.length > 1 && segments[0] == 'p') {
        return segments[1]; // Return the Instagram post ID
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //! Download Facebook video using API (RapidAPI or other similar service)
  Future<void> _downloadFacebookVideo(String url) async {
    setState(() {
      _downloading = true;
      _status = "Downloading Facebook video...";
    });

    try {
      final apiUrl =
          "https://facebook-video-downloader1.p.rapidapi.com/video_downloader.php";
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'X-RapidAPI-Host': 'facebook-video-downloader1.p.rapidapi.com',
          'X-RapidAPI-Key': 'YOUR_RAPIDAPI_KEY', // Replace with your API key
        },
        body: {'url': url},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var videoUrl = jsonResponse['SD'] ?? jsonResponse['HD'];

        if (videoUrl != null) {
          await _downloadVideoFromUrl(videoUrl, "Facebook");
        } else {
          setState(() {
            _status = "No video found at the provided Facebook URL.";
          });
        }
      } else {
        setState(() {
          _status = "Failed to fetch Facebook video URL";
        });
      }
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    } finally {
      setState(() {
        _downloading = false;
      });
    }
  }

  // Generic function to download video from a URL
  Future<void> _downloadVideoFromUrl(String videoUrl, String platform) async {
    try {
      final response = await http.get(Uri.parse(videoUrl));

      // Get the directory to store video
      var dir = await getTemporaryDirectory();
      var filePath = '${dir.path}/$platform-video.mp4';
      var file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);

      // Save video to gallery
      final result = await ImageGallerySaver.saveFile(file.path);

      if (result != null && result["isSuccess"]) {
        setState(() {
          _status = "$platform video saved to gallery";
        });
      } else {
        setState(() {
          _status = "Failed to save $platform video";
        });
      }
    } catch (e) {
      setState(() {
        _status = "Error downloading $platform video: $e";
      });
    }
  }

  // Handle download based on selected platform
  void _handleDownload() {
    if (_controller.text.isNotEmpty) {
      switch (_platform) {
        case "YouTube":
          _downloadYouTubeVideo(_controller.text);
          break;
        case "Instagram":
          _downloadInstagramVideo(_controller.text);
          break;
        case "Facebook":
          _downloadFacebookVideo(_controller.text);
          break;
        default:
          setState(() {
            _status = "Please select a platform";
          });
      }
    } else {
      setState(() {
        _status = "Please enter a valid video URL or ID";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Downloader"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Platform dropdown
            DropdownButton<String>(
              value: _platform,
              items:
                  ["YouTube", "Instagram", "Facebook"].map((String platform) {
                return DropdownMenuItem<String>(
                  value: platform,
                  child: Text(platform),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _platform = value!;
                });
              },
            ),
            SizedBox(height: 20),
            // Text field for video URL/ID input
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter Video URL or ID",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Download button
            _downloading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleDownload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text("Download Video"),
                  ),
            SizedBox(height: 20),
            // Status text
            Text(
              _status,
              style: TextStyle(
                  fontSize: 16,
                  color: _status.contains("Error") ? Colors.red : Colors.green),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
