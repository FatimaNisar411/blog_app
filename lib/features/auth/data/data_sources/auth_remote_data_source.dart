// import 'package:blog_app/core/error/exceptions.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// /// AuthDataSource is an abstract class defining the contract for fetching
// /// data from various sources.
// /// This abstract class outlines the methods that concrete data source
// /// implementations should implement, such as fetching data from a remote API, local database, or any other data source.
// abstract interface class AuthRemoteDataSource {
//   Future<String> signUpWithEmailAndPassword({
//     required String name,
//     required String email,
//     required String password,
//   });

//   Future<String> loginWithEmailAndPassword({
//     required String email,
//     required String password,
//   });
// }

// /// AuthDataSourceImpl is the concrete implementation of the AuthDataSource
// /// interface.
// /// This class implements the methods defined in AuthDataSource to fetch
// /// data from a remote API or other data sources.
// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   SupabaseClient supabaseClient;
//   AuthRemoteDataSourceImpl(this.supabaseClient);
//   @override
//   Future<String> loginWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) {
//     //  TODO: implement loginWithEmailAndPassword
//     throw UnimplementedError();
//   }
//   @override
//   Future<String> signUpWithEmailAndPassword({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await supabaseClient.auth
//           .signUp(email: email, password: password, data: {
//         'name': name,
//       });
//       if (response.user == null) {
//         throw ServerExceptions('User is null');
//       }
//       return response.user!.id;
//     } catch (e) {
//       throw ServerExceptions(e.toString());
//     }
//   }
// }

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerExceptions('User is null');
      }

      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: email,
          );
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {
        'name': name,
      });

      if (response.user == null) {
        // Log if user is null
        print('Error signing up: User is null');
        throw ServerExceptions('User is null');
      }

      // Log successful signup
      print('User signed up successfully: ${response.user!.id}');
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: email,
      );
    } on AuthException catch (e) {
      // Log and throw specific AuthException
      print('AuthException signing up: ${e.message}');
      throw ServerExceptions(e.message);
    } catch (e) {
      // Log and throw any other exceptions
      print('Exception signing up: $e');
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if(currentUserSession!=null){
      final userData=await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);
          return UserModel.fromJson(userData.first).copyWith(
            email:currentUserSession!.user.email,
          );
    }
    return null;
      
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
