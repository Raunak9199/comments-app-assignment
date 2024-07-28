import 'package:comments_app_assignment/utils/firebase_app_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/model/comment_model.dart';
import '../../domain/repository/comment_repo_interface.dart';

class CommentProvider with ChangeNotifier {
  final CommentRepositoryInterface repository;
  final FirebaseRemoteConfigService remoteConfigService;

  List<Comment> _comments = [];
  bool _isLoading = false;
  String _errorMessage = '';

  CommentProvider(this.repository, this.remoteConfigService);

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchComments() async {
    _isLoading = true;
    notifyListeners();

    try {
      _comments = await repository.fetchComments();
      if (_comments.isNotEmpty) {
        _comments = _comments.map((comment) {
          if (remoteConfigService.maskEmail) {
            return comment.copyWith(email: maskEmail(comment.email));
          }
          return comment;
        }).toList();
        _errorMessage = '';
      } else {
        _errorMessage = 'No comments found';
      }
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage);
    }

    _isLoading = false;
    notifyListeners();
  }

  String maskEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex > 3) {
      return '${email.substring(0, 3)}****${email.substring(atIndex)}';
    } else {
      return '***${email.substring(atIndex)}';
    }
  }
}
