import 'package:flutter/material.dart';
import 'package:flutter_qualif/model/post_list.dart';
import 'package:flutter_qualif/model/post_model.dart';
import 'package:flutter_qualif/pages/post_details.dart';


class HomePage extends StatefulWidget {
  final String username;
  const HomePage({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.8; // Adjust the percentage as needed

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Center(child: Image.asset("assets/logo.png", height: 50,)),
        foregroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Expanded(
                child: ListView.builder(
                  itemCount: PostList.postList.length,
                  itemBuilder: (context, index) {
                    PostModel currPost = PostList.postList.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return PostDetails(post: currPost, username: widget.username,);
                        },), );
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(currPost.profile),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currPost.username, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 15, fontWeight: FontWeight.bold),),
                                    Text(currPost.description, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14,), overflow: TextOverflow.ellipsis, maxLines: 2,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 45,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const SizedBox(height: 10,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: 
                                    Image.asset(
                                      currPost.post,
                                      width: imageWidth-30,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return Container();
                                      },
                                    )
                                  ),
                                  const SizedBox(height: 20,),
                                  Icon(Icons.favorite_border, color: Theme.of(context).colorScheme.secondary,),
                                  const SizedBox(height: 10,),
                                  Text("... likes", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 13,)),
                                  const SizedBox(height: 10,),
                                ],
                              )
                            ],
                          ),
                          Divider(color: Theme.of(context).colorScheme.secondary, thickness: 0.1,),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    );
                  },
                ),
              ),
        ),
      );
  }
}