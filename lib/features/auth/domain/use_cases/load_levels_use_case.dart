

import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/domain/entities/level_entity.dart';
import 'package:ostadi_frontend/features/auth/domain/repositories/load_levels_repository.dart';

class LoadLevelsUseCase {
  final LoadLevelsRepository repository;

  LoadLevelsUseCase({required this.repository});

  Future<Either<Failure,List<Level>>> loadLevels() async
  {
    final res = await repository.loadLevels();
    return res;
  }
}