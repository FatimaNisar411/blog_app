import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

/// AuthRepositoryImpl is the concrete implementation of the AuthRepository
/// interface.
/// This class implements the methods defined in AuthRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authDataSource;
  AuthRepositoryImpl(this.authDataSource);

  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(userId);
    } on ServerExceptions catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  // Future<void> signOut();
}
