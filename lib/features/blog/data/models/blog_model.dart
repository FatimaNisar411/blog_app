import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.topics,
    required super.imageUrl,
    required super.updatedAt,
    required super.posterId,
    super.posterName,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'topics': topics,
      'imageUrl': imageUrl,
      'updatedAt': updatedAt.toIso8601String(),
      'posterId': posterId,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      topics: List<String>.from(map['topics']),
      imageUrl: map['imageUrl'],
      updatedAt: DateTime.parse(map['updatedAt']),
      posterId: map['posterId'],
    );
  }
  
  BlogModel copyWith({
    String? id,
    String? title,
    String? posterId,
    List<String>? topics,
    String? imageUrl,
    String? content,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      posterId: posterId ?? this.posterId,
      topics: topics ?? this.topics,
      imageUrl: imageUrl ?? this.imageUrl,
      content: content ?? this.content,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
