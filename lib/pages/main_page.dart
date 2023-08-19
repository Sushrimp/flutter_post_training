import 'package:flutter/material.dart';
import 'package:flutter_qualif/pages/home_page.dart';
import 'package:flutter_qualif/pages/post_page.dart';
import 'package:flutter_qualif/pages/profile_page.dart';
import 'package:flutter_qualif/theme/dark_theme.dart';
import 'package:flutter_qualif/theme/light_theme.dart';
import 'package:flutter_qualif/theme/theme_class.dart';

class MainPage extends StatefulWidget {
  final String username;
  const MainPage({super.key, required this.username});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  int selectedPage = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(username: widget.username),
      PostPage(username: widget.username),
      ProfilePage(username: widget.username),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeClass.isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: pages[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedPage = value;
            });
          },
          currentIndex: selectedPage,
          items: const [
            BottomNavigationBarItem(
              tooltip: "Home",
              label: "Home",
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              tooltip: "Thread",
              label: "Thread",
              icon: Icon(Icons.post_add_outlined),
              activeIcon: Icon(Icons.post_add)
            ),
            BottomNavigationBarItem(
              tooltip: "Profile",
              label: "Profile",
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person)
            ),
          ],
        )
      ),
    );
  }
}