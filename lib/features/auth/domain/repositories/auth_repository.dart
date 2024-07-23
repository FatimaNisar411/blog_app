import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

/// AuthRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract interface class AuthRepository {
  Future<Either<Failure,User >> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getCurrentUser();
  // Future<void> signOut();
}
