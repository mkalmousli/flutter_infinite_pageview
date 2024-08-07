import 'package:flutter/material.dart';
import 'package:infinite_pageview/infinite_pageview.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("infinite_pageview"),
        ),
        body: SafeArea(
          child: InfinitePageView(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  style: const TextStyle(fontSize: 200, color: Colors.white),
                  index.toString(),
                ),
              ),
            ),
            pageSnapping: true,
            onPageChanged: print,
          ),
        ),
      ),
    );
  }
}
