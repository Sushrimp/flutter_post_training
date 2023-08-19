import 'package:flutter_qualif/model/comment_model.dart';
import 'package:flutter_qualif/model/post_model.dart';

class PostList{
  static List<PostModel> postList = [
    PostModel(
      username: "reeynv__",
      description: "hehehe",
      profile: "profile/1.jpg",
      post: "post/1.jpg",
      likes: 1,
      comments: [CommentModel(username: "ellenangln", comment: "<3")]
    ),
    PostModel(
      username: "richbrian",
      description: "the flowers tend to die, but the memories last forever. i don't wanna wait, 'till it goes to waste.",
      profile: "logo.png",
      post: "",
      likes: 1,
      comments: [CommentModel(username: "khainne_", comment: "and so far, I can't find anything that compares to the way you say my name, baby.")]
    )
  ];
}