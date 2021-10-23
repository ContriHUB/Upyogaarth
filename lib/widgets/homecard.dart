import 'package:flutter/material.dart';
import 'package:upyogaarth/utility_screens/compass.dart';
import 'package:upyogaarth/utility_screens/flashlight.dart';
import 'package:upyogaarth/utility_screens/mod_calculator/mod_calculator.dart';
import 'package:upyogaarth/utility_screens/weather.dart';
import 'package:upyogaarth/utility_screens/youtube_downloader.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Color color;
  final IconData icon;
  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
            color: widget.color,
            elevation: 4,
            child: InkWell(
                onTap: openUtility,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.icon),
                      Text(widget.title),
                    ],
                  ),
                ))));
  }

  openUtility() {
    switch (widget.title) {
      case "Flashlight":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FlashlightScreen()));
        break;
      case "Compass":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CompassScreen()));
        break;
      case "Weather":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WeatherScreen()));
        break;
      case "MOD Calculator":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ModCalculator()));
        break;
      case "YouTube Downloader":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const YoutubeDownloaderScreen()));
        break;
    }
  }
}
