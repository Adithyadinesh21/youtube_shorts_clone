import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'video_player_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Shorts Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoListScreen(),
    );
  }
}

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<dynamic> videoList = [];
  int page = 0;

  Future<void> fetchVideos() async {
    final url = 'https://internship-service.onrender.com/videos?page=$page';
    final response = await http.get(Uri.parse(url));
  print("response.statusCode = "+response.statusCode.toString() );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('items')) {
        setState(() {
          videoList.addAll(data['items']);
          print("list"+videoList.length.toString());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/youtube_logo.jpg',
          height: 42,
          width: 90,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.grey[600],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: Colors.grey[600],
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/60111.jpg'),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final video = videoList[index];
          final videoUrl = video['https://www.youtube.com/watch?v=VFDbZk2xhO4'];

          return ListTile(
            title: Text('Video ${index + 1}'),
            onTap: () {
              print("dsadsdasdasda");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoUrl: videoUrl),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
