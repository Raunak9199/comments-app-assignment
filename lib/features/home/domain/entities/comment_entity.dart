import 'package:comments_app_assignment/features/home/data/model/comment_model.dart';

class CommentEntity {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  CommentEntity({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  Comment toModel() {
    return Comment(
      postId: postId!,
      id: id!,
      name: name!,
      email: email!,
      body: body!,
    );
  }

  static CommentEntity fromModel(Comment model) {
    return CommentEntity(
      postId: model.postId,
      id: model.id,
      name: model.name,
      email: model.email,
      body: model.body,
    );
  }

  CommentEntity copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) {
    return CommentEntity(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }
}
