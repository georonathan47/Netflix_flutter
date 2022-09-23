import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failures.dart';
import 'package:netflix_clone/core/usecases/usecase.dart';

import '../entities/netflix.dart';
import '../repositories/netflix_repository.dart';

class GetConcreteNetflixMovie extends UseCase<NetflixEntity, Params> {
  final NetflixRepository? repository;

  GetConcreteNetflixMovie(this.repository);

  @override
  Future<Either<Failures, NetflixEntity?>?> call(Params params) async {
    return await repository!.getConcreteNetflixMovie(params.title);
  }
}

class Params extends Equatable {
  final String title;

  const Params({required this.title});

  @override
  List<Object?> get props => [title];
}
