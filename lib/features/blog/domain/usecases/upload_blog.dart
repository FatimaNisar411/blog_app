import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
      image: params.image,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final File image;
  UploadBlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.image,
  });
}
