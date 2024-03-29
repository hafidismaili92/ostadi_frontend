import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

}

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class ConnectionFailure extends Failure{
  @override
  List<Object?> get props => [];
}
class UnauthenticatedFailure extends Failure
{
   @override
  List<Object?> get props => [];
}
class NoTokenRegistredFailure extends Failure
{
  @override
  List<Object?> get props => [];
}
class UnknownFailure extends Failure{
  @override
  List<Object?> get props => [];
 
}