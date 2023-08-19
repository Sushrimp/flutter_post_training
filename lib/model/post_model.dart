import 'package:flutter_qualif/model/comment_model.dart';

class PostModel {
  String username;
  String description;
  String profile;
  String post;
  int likes;
  List<CommentModel> comments;

  PostModel({
    required this.username,
    required this.description,
    required this.profile,
    required this.post,
    required this.likes,
    required this.comments,
  });
  
}
