// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  final String id;
  final String title;
  final String posterId;
  final List<String> topics;
  final String imageUrl;
  final String content;
  final DateTime updatedAt;
  final String? posterName;

  Blog({
    required this.id,
    required this.title,
    required this.topics,
    required this.imageUrl,
    required this.updatedAt,
    required this.content,
    required this.posterId,
    this.posterName,
  });

}
