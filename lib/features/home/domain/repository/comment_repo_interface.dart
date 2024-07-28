import 'package:comments_app_assignment/features/home/data/model/comment_model.dart';

abstract class CommentRepositoryInterface {
  Future<List<Comment>> fetchComments();
}