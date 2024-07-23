import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// AuthRepositoryImpl is the concrete implementation of the AuthRepository
/// interface.
/// This class implements the methods defined in AuthRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authDataSource;

  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.authDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = authDataSource.currentUserSession;
        if (session == null) {
          return Left(Failure('No internet connection'));
        }
        return right(
          UserModel(
            id: session.user.id,
            name: '',
            email: session.user.email ?? '',
          ),
        );
      }
      final user = await authDataSource.getCurrentUserData();
      if (user == null) {
        return Left(Failure('User not logged in'));
      }

      return Right(user);
    } on ServerExceptions catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await authDataSource.signUpWithEmailAndPassword(
          name: name,
          email: email,
          password: password,
        ));
  }

  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await authDataSource.loginWithEmailAndPassword(
          email: email,
          password: password,
        ));
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection'));
      }
      final user = await fn();
      return Right(user);
    } on sb.AuthException catch (e) {
      return Left(Failure(e.toString()));
    } on ServerExceptions catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // Future<void> signOut();
}
