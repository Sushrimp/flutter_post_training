import 'package:flutter/material.dart';
import 'package:flutter_qualif/pages/login_page.dart';
import 'package:flutter_qualif/theme/theme_class.dart';
import 'package:flutter_qualif/theme/dark_theme.dart';
import 'package:flutter_qualif/theme/light_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> adsImg = ["ads/1.jpg", "ads/2.jpg"];
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeClass.isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text("Profile", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,),),
          foregroundColor: Theme.of(context).colorScheme.background,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.tertiary,),
              itemBuilder: (context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Dark Mode"),
                          value: ThemeClass.isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              ThemeClass.isDarkMode = value;
                            });
                          },  
                        );
                      },
                    )
                  ),
                  PopupMenuItem(
                    child: const Text("Logout"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      },));
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      },));
                    },
                  )
                ];
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text(widget.username, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20),),),
                  const SizedBox(width: 10,),
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
              const SizedBox (height: 10,),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){}, 
                      child: Text("Edit Profile", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12),)
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){}, 
                      child: Text("Share Profile", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12),)
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                ),
                items: 
                  adsImg.map((img) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(img);
                      },
                    );
                  }).toList()
              ),
            ],
          ),
        ),
      ),
    );
  }
}