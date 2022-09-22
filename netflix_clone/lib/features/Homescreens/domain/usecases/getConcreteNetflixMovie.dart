import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failures.dart';

import '../entities/netflix.dart';
import '../repositories/netflix_repository.dart';

class GetConcreteNetflixMovie {
  final NetflixRepository repository;

  GetConcreteNetflixMovie(this.repository);

  Future<Either<Failures, NetflixEntity>?> execute({
    required String? title,
  }) async {
    return await repository.getConcreteNetflixMovie(title!);
  }
}
