import 'package:flutter/material.dart';
import 'package:flutter_qualif/model/comment_model.dart';
import 'package:flutter_qualif/model/post_list.dart';

import 'package:flutter_qualif/model/post_model.dart';
import 'package:flutter_qualif/theme/dark_theme.dart';
import 'package:flutter_qualif/theme/light_theme.dart';
import 'package:flutter_qualif/theme/theme_class.dart';

class PostDetails extends StatefulWidget {
  final String username;
  final PostModel post;
  const PostDetails({
    Key? key,
    required this.username,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  TextEditingController commentController = TextEditingController();
  String? commentError;

  void resetError(){
    setState(() {
      commentError = null;
    });
  }

  void handleComment(){
    resetError();
    bool commentValid = false;
    String comment = commentController.text;
    if(comment.isEmpty){
      commentError = "Comment can't be empty!";
    }
    else {
      commentValid = true;
    }

    if(commentValid){
      commentController.text = "";
      SnackBar snackBar = const SnackBar(content: Text("Comment added !"), duration: Duration(seconds: 1),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      int idx = PostList.postList.indexWhere((PostModel) => PostModel == widget.post);

      PostList.postList.elementAt(idx).comments.add(CommentModel(username: widget.username, comment: comment));
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.8; // Adjust the percentage as needed

    return Theme(
      data: ThemeClass.isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text("Details", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,),),
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Builder(
          builder: (context){
            return Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs:[
                      Tab(icon: Icon(Icons.new_releases, color: Theme.of(context).colorScheme.primary,),),
                      Tab(icon: Icon(Icons.reply, color: Theme.of(context).colorScheme.primary,),),
                    ]
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(widget.post.profile),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(widget.post.username, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 15, fontWeight: FontWeight.bold),),
                                          Text(widget.post.description, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14,), overflow: TextOverflow.ellipsis, maxLines: 100,),
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
                                            widget.post.post,
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
                                TextField(
                                  controller: commentController,
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                  cursorColor: Theme.of(context).colorScheme.secondary,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed:handleComment,
                                      icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary,)
                                    ),
                                    hintText: "Add comment",
                                    labelText: "Comment",
                                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.background), 
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    errorText: commentError,
                                  )
                                ),
                                const SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                          child: ListView.builder(
                            itemCount: widget.post.comments.length,
                            itemBuilder: (context, index) {
                              CommentModel currCom = widget.post.comments.elementAt(index);
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.blue,
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(currCom.username, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 15, fontWeight: FontWeight.bold),),
                                            Text(currCom.comment, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14,), overflow: TextOverflow.ellipsis, maxLines: 100,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Divider(color: Theme.of(context).colorScheme.secondary, thickness: 0.1,),
                                  const SizedBox(height: 10,),
                                ],
                              );
                            }
                          ),
                        )
                      ],
                    ),
                  )
                      
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}