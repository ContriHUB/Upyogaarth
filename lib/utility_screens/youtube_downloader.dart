import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';

class YoutubeDownloaderScreen extends StatefulWidget {
  const YoutubeDownloaderScreen({Key? key}) : super(key: key);

  @override
  State<YoutubeDownloaderScreen> createState() =>
      _YoutubeDownloaderScreenState();
}

class _YoutubeDownloaderScreenState extends State<YoutubeDownloaderScreen> {
  String? _linkStatus =
      'Paste the link and press the download button to start.';
  final TextEditingController _inputController = TextEditingController();

  String _youtubeLink = 'https://youtu.be/dQw4w9WgXcQ';
  bool _inputEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _inputController.dispose();
    super.dispose();
  }

  Future<void> downloadVideo() async {
    setState(() {
      _youtubeLink = _inputController.toString();
      _linkStatus = "Verifying...";
      _inputEnabled = false;
    });
    try {
      await (FlutterYoutubeDownloader.extractYoutubeLink(_youtubeLink, 18));
    } on PlatformException {
      setState(() {
        _linkStatus = "Link not found! Retry or check the URL.";
        _inputEnabled = false;
      });
    }

    if (!mounted) {
      setState(() {
        _linkStatus = "Link not found! Retry or check the URL.";
        _inputEnabled = false;
      });
      return;
    }

    setState(() {
      _linkStatus = "Link found! Starting Download...";
      _inputEnabled = false;
    });

    var result = await FlutterYoutubeDownloader.downloadVideo(
        _youtubeLink, "VideoUpyogaarth", 22);

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Downloader'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                enabled: _inputEnabled,
                controller: _inputController,
                decoration: InputDecoration(
                  hintText: 'Enter URL',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Status: $_linkStatus"),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: OutlinedButton(
                  onPressed: downloadVideo,
                  child: const Icon(Icons.download),
                ))
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: downloadVideo,
      //   child: const Icon(Icons.download_rounded),
      // ),
    );
  }
}
