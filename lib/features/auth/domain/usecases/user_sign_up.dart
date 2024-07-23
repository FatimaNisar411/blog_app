import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';



/// use case is a class responsible for encapsulating a specific piece of business logic or 
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class UserSignUp implements UseCase<User,   UserSignUpParams> {
	  
   final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async{
    return await  authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
   
  }
}


class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}