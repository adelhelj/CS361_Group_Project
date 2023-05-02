import 'package:flutter/material.dart';
import 'package:grateful/pages/feed_page.dart';
import 'package:grateful/pages/posts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    const FeedPage(),
    const PostsPage(),
  ];

  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.volunteer_activism_sharp,
            color: colorScheme.primary
          ),
          centerTitle: true,
          title: Text(
            "Grateful",
            style: TextStyle(
              letterSpacing: 1.0,
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 25
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                left: _padding(_deviceWidth), 
                right: _padding(_deviceWidth)
              ),
              child: GestureDetector(
                onTap:() async { 
                  Navigator.popAndPushNamed(context, 'start'); 
                },
                child: Icon(
                  Icons.logout,
                  color: colorScheme.error
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: gratefulBottomNavigationBar(colorScheme),
        body: _pages[_currentPage],
    );
  }

  double _padding(double _deviceWidth) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return _deviceWidth * 0.05;
    } else {
      return _deviceWidth * 0.03;
    }
  }

  Widget gratefulBottomNavigationBar(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        border: Border(
          top: BorderSide(
            color: colorScheme.primary,
            width: 1.0,
          )
        ),
      ),
      child: BottomNavigationBar(
        onTap: (_index) {
          setState(() {
           _currentPage = _index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: colorScheme.primary,),
            label: 'Feed',
            activeIcon: Icon(Icons.home, color: colorScheme.primary)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_outlined, color: colorScheme.primary),
            label: 'Posts',
            activeIcon: Icon(Icons.volunteer_activism, color: colorScheme.primary),
          ),
        ],
        currentIndex: _currentPage,
      ),
    );
  }
}
