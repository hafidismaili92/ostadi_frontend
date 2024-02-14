import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/utils/classes/login_params.dart';

abstract class LoginRepository {

Future<Either<Failure,String>> getAndStoreToken(Loginparams params);

}



