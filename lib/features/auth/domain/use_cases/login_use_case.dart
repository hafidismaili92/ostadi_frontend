import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/login_repository.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure,bool>> tryLogin(Loginparams params) async
  {
    final res = await repository.getAndStoreToken(params);
    return res.fold((failure) =>  Left(failure), (token) => const Right(true));
  }
}

