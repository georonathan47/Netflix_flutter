import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failures.dart';
import 'package:netflix_clone/core/usecases/usecase.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';
import 'package:netflix_clone/features/Homescreens/domain/repositories/netflix_repository.dart';

class GetLatestNetflixMovie extends UseCase<NetflixEntity, NoParams> {
  final NetflixRepository repository;

  GetLatestNetflixMovie(this.repository);

  @override
  Future<Either<Failures, NetflixEntity>?> call(NoParams params) async {
    return await repository.getLatestNetflixMovie();
  }
}
