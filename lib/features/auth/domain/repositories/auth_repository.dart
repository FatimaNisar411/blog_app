import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

/// AuthRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

   Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  // Future<void> signOut();
}
