import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/netflix.dart';
import '../repositories/netflix_repository.dart';

class GetTopRatedNetflixMovie extends UseCase<NetflixEntity, NoParams> {
  final NetflixRepository repository;

  GetTopRatedNetflixMovie(this.repository);

  @override
  Future<Either<Failures, NetflixEntity>?> call(NoParams params) async {
    return await repository.getTopRatedNetflixMovies();
  }
}
