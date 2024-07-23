// import 'dart:io';

// import 'package:blog_app/core/error/exceptions.dart';
// import 'package:blog_app/features/blog/data/models/blog_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// abstract interface class BlogRemoteDataSource {
//   Future<BlogModel> uploadBlogs(BlogModel blog);
//   Future<String> uploadBlogImage({
//     required BlogModel blog,
//     required File image,
//   });
//   Future<List<BlogModel>> getAllBlogs();
// }

// class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
//   final SupabaseClient supabaseClient;
//   BlogRemoteDataSourceImpl(this.supabaseClient);
//   @override
//   Future<BlogModel> uploadBlogs(BlogModel blog) async {
//     try {
//       final blogData =
//           await supabaseClient.from('blogs').insert(blog.toJson()).select();

//       //upload blog to remote
//       return BlogModel.fromJson(blogData.first);
//     } catch (e) {
//       throw ServerExceptions(e.toString());
//     }
//   }

//   @override
//   Future<String> uploadBlogImage(
//       {required BlogModel blog, required File image}) async {
//     try {
//       await supabaseClient.storage.from('blog_images').upload(
//             // 'blog_images/${blog.id}',
//             blog.id,
//             image,
//           );
//       return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
//     } catch (e) {
//       throw ServerExceptions(e.toString());
//     }
//   }

//   @override
//   Future<List<BlogModel>> getAllBlogs() async {
//     try {
//       final blogs= await supabaseClient.from('blogs').select('*,profiles(name)');
//       return blogs.map((blog)=>BlogModel.fromJson(blog).copyWith(posterName:blog['profiles']['name'])).toList();
//     } catch (e) {
//       throw ServerExceptions(e.toString());
//     }
//   }
// }
import 'dart:io';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlogs(BlogModel blog);
  Future<String> uploadBlogImage({
    required BlogModel blog,
    required File image,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlogs(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      print('PostgrestException: ${e.message}');
      throw ServerExceptions('Failed to upload blog: ${e.message}');
    } on SocketException catch (e) {
      print('SocketException: ${e.message}');
      throw ServerExceptions('No Internet connection: ${e.message}');
    } catch (e) {
      print('Unknown Exception: $e');
      throw ServerExceptions('Unknown error occurred: $e');
    }
  }

  @override
  Future<String> uploadBlogImage({
    required BlogModel blog,
    required File image,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            image,
          );
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } on StorageException catch (e) {
      print('StorageException: ${e.message}');
      throw ServerExceptions('Failed to upload image: ${e.message}');
    } on SocketException catch (e) {
      print('SocketException: ${e.message}');
      throw ServerExceptions('No Internet connection: ${e.message}');
    } catch (e) {
      print('Unknown Exception: $e');
      throw ServerExceptions('Unknown error occurred: $e');
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*,profiles(name)');

      return blogs
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } on PostgrestException catch (e) {
      print('PostgrestException: ${e.message}');
      throw ServerExceptions('Failed to fetch blogs: ${e.message}');
    } on SocketException catch (e) {
      print('SocketException: ${e.message}');
      throw ServerExceptions('No Internet connection: ${e.message}');
    } catch (e) {
      print('Unknown Exception: $e');
      throw ServerExceptions('Unknown error occurred: $e');
    }
  }
}
