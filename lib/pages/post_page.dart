import 'package:flutter/material.dart';
import 'package:flutter_qualif/model/comment_model.dart';
import 'package:flutter_qualif/model/post_list.dart';
import 'package:flutter_qualif/model/post_model.dart';

class PostPage extends StatefulWidget {
  final String username;
  const PostPage({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController threadController = TextEditingController();
  String? threadError;

  void resetError(){
    setState(() {
      threadError = null;
    });
  }

  void handleThread(){
    resetError();
    bool threadValid = false;
    String thread = threadController.text;

    if(thread.isEmpty || thread.length < 10){
      threadError = "Thread must be more than 10 characters.";
    }
    else{
      threadValid = true;
    }

    if(threadValid){
      PostList.postList.add(PostModel(
        username: widget.username, 
        description: thread,
        profile: "logo.png",
        post: "",
        likes: 0,
        comments: [CommentModel(username: "reeynv_", comment: "i was here !")]
      ));

      threadController.text = "";
      SnackBar snackBar = const SnackBar(content: Text("Thread added !"), duration: Duration(seconds: 1),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Center(child: Text("New Thread", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,),)),
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          children: [
            TextField(
              controller: threadController,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: InputDecoration(
                hintText: "Add thread",
                labelText: "Thread",
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
                errorText: threadError,
              )
            ),
            const SizedBox(height: 10,),
            IconButton(
              onPressed:handleThread,
              icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary,)
            )
          ],
        ),
      ),
    );
  }
}