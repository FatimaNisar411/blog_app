class Failure{
  final String message;

  Failure([this.message = 'an unexpected error occured']);

  @override
  String toString() => message;
}