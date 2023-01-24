import 'package:flutter/material.dart';
import 'responsive/desktopbody.dart';
import 'responsive/mobilebody.dart';
import 'responsive/reponsive_layout.dart';

// Uncomment lines 3 and 6 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter layout demo',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('TODOLISTAPPLICATION'),
            backgroundColor: Color.fromARGB(255, 6, 78, 1),
          ),
          body: Homepage()),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobileBody: MobileBody(),
      desktopBody: DesktopBody(),
    );
  }
}
