import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:upyogaarth/widgets/homecard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: cardList.length,
            itemBuilder: (context, index) {
              return cardList[index];
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }),
      ),
    );
  }

  List<HomeCard> cardList = [
    const HomeCard(title: "Flashlight", color: Colors.redAccent, icon: Icons.flashlight_on),
    const HomeCard(title: "Compass", color: Colors.blueGrey, icon: Icons.explore),
    const HomeCard(title: "Weather", color: Colors.lightGreen, icon: Icons.wb_sunny),
    const HomeCard( title: "MOD Calculator", color: Colors.deepOrangeAccent, icon: Icons.calculate),
    const HomeCard( title: "YouTube Downloader", color: Colors.deepPurple, icon: Icons.download),
  ];
}
