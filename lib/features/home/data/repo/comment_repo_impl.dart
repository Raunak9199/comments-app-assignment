import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repository/comment_repo_interface.dart';
import '../model/comment_model.dart';

class CommentRepositoryImpl implements CommentRepositoryInterface {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/comments';

  @override
  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
