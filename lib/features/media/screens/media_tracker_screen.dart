import 'package:flutter/material.dart';

class MediaTrackerScreen extends StatefulWidget {
  const MediaTrackerScreen({super.key});

  @override
  State<MediaTrackerScreen> createState() => _MediaTrackerScreenState();
}

class _MediaTrackerScreenState extends State<MediaTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Media'),),
    );
  }
}
