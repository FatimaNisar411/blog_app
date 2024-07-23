part of 'blog_bloc.dart';

sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {
  final List<Blog> blogs;

  const BlogSuccess(this.blogs);
}

final class BlogUploadSuccess extends BlogState {}
 
final class BlogFailure extends BlogState {
  final String message;

  const BlogFailure(this.message);

 
} 