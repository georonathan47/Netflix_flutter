import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/netflix.dart';
import '../repositories/netflix_repository.dart';

class GetNowPlayingNetflixMovie extends UseCase<NetflixEntity, NoParams> {
  final NetflixRepository repository;

  GetNowPlayingNetflixMovie(this.repository);

  @override
  Future<Either<Failures, NetflixEntity>?> call(NoParams params) async {
    return await repository.getNowPlayingNetflixMovies();
  }
}
