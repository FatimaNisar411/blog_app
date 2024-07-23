import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {

  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  }) : _getAllBlogs = getAllBlogs,
        _uploadBlog = uploadBlog,
  super(BlogInitial()) {

    on<BlogEvent>(
        (event, emit) => emit(BlogLoading())); // This might be unnecessary
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAll>(_onBlogGetAll);
  }

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics,
        image: event.image,
      ),
    );
    res.fold(
      (l) {
        emit(BlogFailure(l.message));
      },
      (blog) {
        emit(BlogUploadSuccess());
      },
    );
  }

  void _onBlogGetAll(
    BlogGetAll event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());
    res.fold(
      (l) {
        emit(BlogFailure(l.message));
      },
      (blogs) {
        emit(BlogSuccess(blogs));
      },
    );
  }
}
