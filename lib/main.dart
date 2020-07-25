import 'package:flutter/material.dart';
import 'package:wiffer_app_flutter/screens/Home.dart';
import 'package:wiffer_app_flutter/screens/Search.dart';
import 'package:wiffer_app_flutter/screens/Upload.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  List tabs = [
    Home(),
    Upload(),
    Search(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wifs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wiffs App'),
        ),
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.surround_sound),
              title: Text('Wifs'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload),
              title: Text('Upload'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
